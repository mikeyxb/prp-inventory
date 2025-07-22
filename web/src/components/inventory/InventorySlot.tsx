import React, { useCallback, useRef } from 'react';
import { DragSource, Inventory, InventoryType, Slot, SlotWithItem } from '../../typings';
import { useDrag, useDragDropManager, useDrop } from 'react-dnd';
import { useAppDispatch } from '../../store';
import { onDrop } from '../../dnd/onDrop';
import { onBuy } from '../../dnd/onBuy';
import { Items } from '../../store/items';
import { canCraftItem, canPurchaseItem, getItemUrl, isSlotWithItem } from '../../helpers';
import { onUse } from '../../dnd/onUse';
import { onCraft } from '../../dnd/onCraft';
import useNuiEvent from '../../hooks/useNuiEvent';
import { ItemsPayload } from '../../reducers/refreshSlots';
import { closeTooltip, openTooltip } from '../../store/tooltip';
import { openContextMenu } from '../../store/contextMenu';
import { useMergeRefs } from '@floating-ui/react';
import { Locale } from '../../store/locale';
import dragSound from '../../assets/sounds/drag.wav';

export const getColor = (rarity: string): { text: string; background: string } => {
  const defaultColor = { text: '#757575', background: 'radial-gradient(#00000050, #51515150)' };
  if (!rarity) return defaultColor;
  
  switch (rarity.toLowerCase()) {
    case 'rare':
      return { text: '#0ea5e9', background: 'radial-gradient(#00000000, #0ea5e920)' };
    case 'epic':
      return { text: '#db2777', background: 'radial-gradient(#00000000, #be185d25)' };
    case 'legendary':
      return { text: '#a16207', background: 'radial-gradient(#00000000, #a1620725)' };
    case 'uncommon':
      return { text: '#84cc16', background: 'radial-gradient(#00000050, #84cc1610)' };
    default:
      return defaultColor;
  }
};

interface SlotProps {
  inventoryId: Inventory['id'];
  inventoryType: Inventory['type'];
  inventoryGroups: Inventory['groups'];
  item: Slot;
  query: string;
}

const InventorySlot: React.ForwardRefRenderFunction<HTMLDivElement, SlotProps> = (
  { item, inventoryId, inventoryType, inventoryGroups, query },
  ref
) => {
  const manager = useDragDropManager();
  const dispatch = useAppDispatch();
  const timerRef = useRef<number | null>(null);

  const matchesQuery = (item: Slot | null, query: string = '') => {
    if (!item || typeof item.name !== 'string') return true; // Return true if slot is empty
    return (item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name)
      .toLowerCase()
      .includes(query.toLowerCase());
  };

  const canDrag = useCallback(() => {
    return (
      canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) &&
      canCraftItem(item, inventoryType) &&
      matchesQuery(item, query)
    );
  }, [item, inventoryType, inventoryGroups, query]);

  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({
        isDragging: monitor.isDragging(),
      }),
      item: () =>
        isSlotWithItem(item, inventoryType !== InventoryType.SHOP) && matchesQuery(item, query)
          ? {
              inventory: inventoryType,
              item: item,
              image: item?.name && getItemUrl(item),
            }
          : null,
      canDrag,
    }),
    [inventoryType, item, canDrag, query]
  );

  const [{ isOver }, drop] = useDrop<DragSource, void, { isOver: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({
        isOver: monitor.isOver(),
      }),
      drop: (source) => {
        const audio = new Audio(dragSound);
        audio.play();
        dispatch(closeTooltip());
        switch (source.inventory) {
          case InventoryType.SHOP:
            onBuy(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
          case InventoryType.CRAFTING:
            onCraft(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
          default:
            onDrop(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
        }
      },
      canDrop: (source) =>
        (source.item.slot !== item.slot || source.inventory !== inventoryType) &&
        inventoryType !== InventoryType.SHOP &&
        inventoryType !== InventoryType.CRAFTING,
    }),
    [inventoryType, item]
  );

  useNuiEvent('refreshSlots', (data: { items?: ItemsPayload | ItemsPayload[] }) => {
    if (!isDragging && !data.items) return;
    if (!Array.isArray(data.items)) return;

    const itemSlot = data.items.find(
      (dataItem) => dataItem.item.slot === item.slot && dataItem.inventory === inventoryId
    );

    if (!itemSlot) return;

    manager.dispatch({ type: 'dnd-core/END_DRAG' });
  });

  const connectRef = (element: HTMLDivElement) => drag(drop(element));

  const handleContext = (event: React.MouseEvent<HTMLDivElement>) => {
    event.preventDefault();
    if (inventoryType !== 'player' || !isSlotWithItem(item)) return;

    dispatch(openContextMenu({ item, coords: { x: event.clientX, y: event.clientY } }));
  };

  const handleClick = (event: React.MouseEvent<HTMLDivElement>) => {
    dispatch(closeTooltip());
    if (timerRef.current) clearTimeout(timerRef.current);
    if (event.ctrlKey && isSlotWithItem(item) && inventoryType !== 'shop' && inventoryType !== 'crafting') {
      onDrop({ item: item, inventory: inventoryType });
    } else if (event.altKey && isSlotWithItem(item) && inventoryType === 'player') {
      onUse(item);
    }
  };

  const refs = useMergeRefs([connectRef, ref]);

  return (
    <div
      ref={refs}
      onContextMenu={handleContext}
      onClick={handleClick}
      className={`relative w-[115px] h-[115px] border border-transparent item-slot-border`}
      style={
        {
          '--borderColor': matchesQuery(item, query) ? getColor(Items[item.name as string]?.rarity as string).text : undefined,
          filter:
            !canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) ||
            !canCraftItem(item, inventoryType)
              ? 'brightness(80%) grayscale(100%)'
              : undefined,
        } as React.CSSProperties
      }
    >
      {isSlotWithItem(item) && matchesQuery(item, query) && (
        <div
          className="p-1.5 text-[#a8a8a8] text-xs relative w-full h-full cursor-pointer"
          onMouseEnter={() => {
            timerRef.current = window.setTimeout(() => {
              dispatch(openTooltip({ item, inventoryType }));
            }, 500) as unknown as number;
          }}
          onMouseLeave={() => {
            dispatch(closeTooltip());
            if (timerRef.current) {
              clearTimeout(timerRef.current);
              timerRef.current = null;
            }
          }}
        >
          <img
            src={`${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`}
            className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-0"
            alt={item.name}
          />

          <div className="leading-3 font-[350] relative z-10">
            <p
              className="absolute top-0 right-0 text-[10px] font-medium"
              style={{
                color: Items[item.name as string]?.rarity === 'common' ? '#ffffff' : getColor(Items[item.name as string]?.rarity as string).text,
              }}
            >
              {Items[item.name as string]?.rarity?.toUpperCase()}
            </p>
            <p>{item.count > 1 ? item.count.toLocaleString('en-us') + `x` : ''}</p>
            <p className="text-[11px]">
              {item.weight > 0
                ? item.weight >= 1000
                  ? `${(item.weight / 1000).toLocaleString('en-us', {
                      minimumFractionDigits: 1,
                    })}kg `
                  : `${item.weight.toLocaleString('en-us', {
                      minimumFractionDigits: 1,
                    })}g `
                : ''}
            </p>
          </div>
          <p className="absolute text-white w-1/2 bottom-[7px] left-[7px] font-semibold z-10">
            {item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}
          </p>
          {inventoryType !== 'shop' && item?.durability !== undefined && (
            <div className="absolute h-1 w-full bottom-0 left-0">
              <div
                className="h-full"
                style={{ backgroundColor: getColor(Items[item.name as string]?.rarity as string).text, width: `${item.durability}%` }}
              ></div>
            </div>
          )}
          {inventoryType === 'shop' && item?.price !== undefined && (
            <div className="absolute z-10">
              {item?.currency !== 'money' && item.currency !== 'black_money' && item.price > 0 && item.currency ? (
                <div className="flex items-center gap-1">
                  <img
                    src={item.currency ? getItemUrl(item.currency) : 'none'}
                    alt="item-image"
                    style={{
                      imageRendering: '-webkit-optimize-contrast',
                      height: 'auto',
                      width: '2vh',
                      backfaceVisibility: 'hidden',
                      transform: 'translateZ(0)',
                    }}
                  />
                  <p>{item.price.toLocaleString('en-us')}</p>
                </div>
              ) : (
                <>
                  {item.price > 0 && (
                    <div className="flex items-center gap-1">
                      <p>
                        {Locale.$ || '$'}
                        {item.price.toLocaleString('en-us')}
                      </p>
                    </div>
                  )}
                </>
              )}
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default React.memo(React.forwardRef(InventorySlot));
