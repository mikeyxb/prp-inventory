import React, { useCallback, useEffect, useRef } from 'react';
import { DragSource, Inventory, InventoryType, Slot, SlotWithItem } from '../../typings';
import { useDrag, useDragDropManager, useDrop } from 'react-dnd';
import { useAppDispatch } from '../../store';
import { onDrop } from '../../dnd/onDrop';
import { onBuy } from '../../dnd/onBuy';
import { Items } from '../../store/items';
import { canCraftItem, canPurchaseItem, getItemUrl, isSlotWithItem } from '../../helpers';
import { onUse } from '../../dnd/onUse';
import { Locale } from '../../store/locale';
import { onCraft } from '../../dnd/onCraft';
import useNuiEvent from '../../hooks/useNuiEvent';
import { ItemsPayload } from '../../reducers/refreshSlots';
import { closeTooltip, openTooltip } from '../../store/tooltip';
import { openContextMenu } from '../../store/contextMenu';
import { useMergeRefs } from '@floating-ui/react';

const getColor = (rarity: string): { text: string; background: string } => {
  switch (rarity.toLowerCase()) {
    case 'rare': return { text: '#0ea5e9', background: 'radial-gradient(#00000000, #0ea5e920)' };
    case 'epic': return { text: '#db2777', background: 'radial-gradient(#00000000, #be185d25)' };
    case 'legendary': return { text: '#a16207', background: 'radial-gradient(#00000000, #a1620725)' };
    case 'uncommon': return { text: '#84cc16', background: 'radial-gradient(#00000050, #84cc1610)' };
    default: return { text: '#636363', background: 'radial-gradient(#00000050, #31313150)' };
  };
};

interface SlotProps {
  inventoryId: Inventory['id'];
  inventoryType: Inventory['type'];
  inventoryGroups: Inventory['groups'];
  item: Slot;
}

const InventorySlot: React.ForwardRefRenderFunction<HTMLDivElement, SlotProps> = (
  { item, inventoryId, inventoryType, inventoryGroups },
  ref
) => {
  const manager = useDragDropManager();
  const dispatch = useAppDispatch();
  const timerRef = useRef<number | null>(null);

  const canDrag = useCallback(() => {
    return canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) && canCraftItem(item, inventoryType);
  }, [item, inventoryType, inventoryGroups]);

  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({
        isDragging: monitor.isDragging(),
      }),
      item: () =>
        isSlotWithItem(item, inventoryType !== InventoryType.SHOP)
          ? {
              inventory: inventoryType,
              item: {
                name: item.name,
                slot: item.slot,
                rarity: item.rarity || 'common'
              },
              image: item?.name && `url(${getItemUrl(item) || 'none'}`,
            }
          : null,
      canDrag,
    }),
    [inventoryType, item]
  );

  const [{ isOver }, drop] = useDrop<DragSource, void, { isOver: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({
        isOver: monitor.isOver(),
      }),
      drop: (source) => {
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
      className={`relative w-[115px] h-[115px] rounded-[3px] border border-transparent item-slot-border
        [background:radial-gradient(#00000050,_#31313150)] hover:[background:radial-gradient(#00000050,_#42424250)]`}
      style={{
        background: item.rarity !== 'common' ? getColor(item.rarity as string).background : '',
        '--borderColor': getColor(item.rarity as string).text,
        filter:
          !canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) || !canCraftItem(item, inventoryType)
            ? 'brightness(80%) grayscale(100%)'
            : undefined
      } as React.CSSProperties}
    >
      {isSlotWithItem(item) && (
        <div className={`p-1.5 text-[#a8a8a8] text-xs`}>
          <img src={`${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`} className='absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-10'/>
          <div className='leading-3 font-[350]'>
            <p className='absolute top-[5px] right-[5px] text-[10px] font-medium' style={{ color: item.rarity === 'common' ? '#ffffff' : `${getColor(item.rarity as string).text}` }}>{item.rarity?.toUpperCase()}</p>
            <p>{item.count > 1 ? item.count.toLocaleString('en-us') + `x` : ''}</p>
            <p className='text-[11px]'>
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
          <p className="absolute text-white w-1/2 bottom-[7px] left-[7px] font-semibold">{item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}</p>
        </div>
      )}
    </div>
  );
};

export default React.memo(React.forwardRef(InventorySlot));
