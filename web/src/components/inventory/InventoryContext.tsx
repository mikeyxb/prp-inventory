import { onUse } from '../../dnd/onUse';
import { onGive } from '../../dnd/onGive';
import { onDrop } from '../../dnd/onDrop';
import { Items } from '../../store/items';
import { fetchNui } from '../../utils/fetchNui';
import { Locale } from '../../store/locale';
import { isSlotWithItem } from '../../helpers';
import { setClipboard } from '../../utils/setClipboard';
import { useAppDispatch, useAppSelector } from '../../store';
import React, { useEffect } from 'react';
import { Menu, MenuItem } from '../utils/menu/Menu';
import Fade from '../utils/transitions/Fade';
import { InventoryType, SlotWithItem } from '../../typings';
import { selectItemAmount, setItemAmount } from '../../store/inventory';

interface DataProps {
  action: string;
  component?: string;
  slot?: number;
  serial?: string;
  id?: number;
}

interface Button {
  label: string;
  index: number;
  group?: string;
}

interface Group {
  groupName: string | null;
  buttons: ButtonWithIndex[];
}

interface ButtonWithIndex extends Button {
  index: number;
}

interface GroupedButtons extends Array<Group> {}

const InventoryContext: React.FC = () => {
  const contextMenu = useAppSelector((state) => state.contextMenu);
  const item = contextMenu.item;
  const [showSplit, setShowSplit] = React.useState<boolean | SlotWithItem>(false);
  const dispatch = useAppDispatch();

  const handleClick = (data: DataProps) => {
    if (!item) return;

    switch (data && data.action) {
      case 'use':
        onUse({ name: item.name, slot: item.slot });
        break;
      case 'give':
        onGive({ name: item.name, slot: item.slot });
        break;
      case 'drop':
        isSlotWithItem(item) && onDrop({ item: item, inventory: 'player' });
        break;
      case 'remove':
        fetchNui('removeComponent', { component: data?.component, slot: data?.slot });
        break;
      case 'removeAmmo':
        fetchNui('removeAmmo', item.slot);
        break;
      case 'copy':
        setClipboard(data.serial || '');
        break;
      case 'split':
        setShowSplit(showSplit === false ? item : false);
        break;
      case 'custom':
        fetchNui('useButton', { id: (data?.id || 0) + 1, slot: item.slot });
        break;
    }
  };

  const groupButtons = (buttons: any): GroupedButtons => {
    return buttons.reduce((groups: Group[], button: Button, index: number) => {
      if (button.group) {
        const groupIndex = groups.findIndex((group) => group.groupName === button.group);
        if (groupIndex !== -1) {
          groups[groupIndex].buttons.push({ ...button, index });
        } else {
          groups.push({
            groupName: button.group,
            buttons: [{ ...button, index }],
          });
        }
      } else {
        groups.push({
          groupName: null,
          buttons: [{ ...button, index }],
        });
      }
      return groups;
    }, []);
  };

  return (
    <>
      <Menu>
        <MenuItem onClick={() => handleClick({ action: 'use' })} label={Locale.ui_use || 'Use'} />
        <MenuItem onClick={() => handleClick({ action: 'split' })} label={Locale.ui_split || 'Split'} />
        <MenuItem onClick={() => handleClick({ action: 'give' })} label={Locale.ui_give || 'Give'} />
        {item && item.metadata?.ammo > 0 && (
          <MenuItem onClick={() => handleClick({ action: 'removeAmmo' })} label={Locale.ui_remove_ammo} />
        )}
        {item && item.metadata?.serial && (
          <MenuItem
            onClick={() => handleClick({ action: 'copy', serial: item.metadata?.serial })}
            label={Locale.ui_copy || 'Copy'}
          />
        )}
        {item && item.metadata?.components && item.metadata?.components.length > 0 && (
          <Menu label={Locale.ui_removeattachments}>
            {item &&
              item.metadata?.components.map((component: string, index: number) => (
                <MenuItem
                  key={index}
                  onClick={() => handleClick({ action: 'remove', component, slot: item.slot })}
                  label={Items[component]?.label || ''}
                />
              ))}
          </Menu>
        )}
        {((item && item.name && Items[item.name]?.buttons?.length) || 0) > 0 && (
          <>
            {item &&
              item.name &&
              groupButtons(Items[item.name]?.buttons).map((group: Group, index: number) => (
                <React.Fragment key={index}>
                  {group.groupName ? (
                    <Menu label={group.groupName}>
                      {group.buttons.map((button: Button) => (
                        <MenuItem
                          key={button.index}
                          onClick={() => handleClick({ action: 'custom', id: button.index })}
                          label={button.label}
                        />
                      ))}
                    </Menu>
                  ) : (
                    group.buttons.map((button: Button) => (
                      <MenuItem
                        key={button.index}
                        onClick={() => handleClick({ action: 'custom', id: button.index })}
                        label={button.label}
                      />
                    ))
                  )}
                </React.Fragment>
              ))}
          </>
        )}
      </Menu>
      <SplitContainer
        data={showSplit as SlotWithItem}
        close={() => {
          setShowSplit(false);
          dispatch(setItemAmount(0));
        }}
        split={() => {
          if (!item) return;

          const source = {
            inventory: InventoryType.PLAYER,
            item: item,
          };

          onDrop(source, undefined, true);

          setShowSplit(false);
          dispatch(setItemAmount(0));
        }}
      />
    </>
  );
};

export default InventoryContext;

const SplitContainer: React.FC<{
  data: SlotWithItem;
  close: () => void;
  split: () => void;
}> = ({ data, close, split }) => {
  const itemAmount = useAppSelector(selectItemAmount);
  const dispatch = useAppDispatch();

  useEffect(() => {
    if (data) dispatch(setItemAmount(1));
  }, [data]);

  const inputHandler = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.target.valueAsNumber =
      isNaN(event.target.valueAsNumber) || event.target.valueAsNumber < 0 ? 0 : Math.floor(event.target.valueAsNumber);
    dispatch(setItemAmount(event.target.valueAsNumber));
  };

  const quickSet = (divider: number) => {
    dispatch(setItemAmount(Math.max(1, Math.floor(data.count / divider))));
  };

  return (
    <>
      <Fade in={data ? true : false}>
        <div className="font-[Inter] text-white bg-black/75 absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[250px] py-5 px-5 rounded-lg border border-neutral-600 flex flex-col items-center justify-center gap-3">
          <p className="font-semibold text-2xl">{(Locale.ui_split || 'Split').toUpperCase()}</p>
          <div className="flex items-center flex-col gap-2 w-full">
            <p className="text-[15px]">{Locale.quantity || 'Quantity'}</p>
            <input
              type="number"
              min={1}
              max={data.count}
              value={itemAmount}
              onChange={inputHandler}
              className="bg-black/60 focus:outline-none rounded px-2 py-1 w-1/2 text-center border border-neutral-600"
            />
            <input
              type="range"
              min={1}
              max={data.count}
              value={itemAmount}
              onChange={inputHandler}
              className="w-full h-1.5 bg-black/65 rounded-full outline outline-1 outline-neutral-700/65 appearance-none cursor-pointer my-2
              [&::-webkit-slider-thumb]:appearance-none
              [&::-webkit-slider-thumb]:w-3.5
              [&::-webkit-slider-thumb]:h-3.5
              [&::-webkit-slider-thumb]:bg-cyan-500
              [&::-webkit-slider-thumb]:rounded-full
              [&::-webkit-slider-thumb]:drop-shadow-[0_0_10px_#84cc16]"
            />
          </div>
          <div className="w-full flex items-center gap-2">
            <button
              className="bg-black/65 w-full py-1.5 border border-neutral-600 rounded
            hover:bg-cyan-500/20 hover:border-cyan-500 duration-200"
              onClick={() => quickSet(2)}
            >
              1/2
            </button>
            <button
              className="bg-black/65 w-full py-1.5 border border-neutral-600 rounded
            hover:bg-cyan-500/20 hover:border-cyan-500 duration-200"
              onClick={() => quickSet(3)}
            >
              1/3
            </button>
            <button
              className="bg-black/65 w-full py-1.5 border border-neutral-600 rounded
            hover:bg-cyan-500/20 hover:border-cyan-500 duration-200"
              onClick={() => quickSet(4)}
            >
              1/4
            </button>
          </div>
          <div className="w-full flex items-center gap-2">
            <button
              className="bg-black/65 w-full py-1.5 border border-neutral-600 rounded text-sm
            hover:bg-cyan-500/20 hover:border-cyan-500 duration-200"
              onClick={close}
            >
              {Locale.ui_cancel || 'Cancel'}
            </button>
            <button
              className="bg-black/65 w-full py-1.5 border border-neutral-600 rounded text-sm
            hover:bg-cyan-500/20 hover:border-cyan-500 duration-200"
              onClick={split}
            >
              {Locale.ui_split || 'Split'}
            </button>
          </div>
        </div>
      </Fade>
    </>
  );
};
