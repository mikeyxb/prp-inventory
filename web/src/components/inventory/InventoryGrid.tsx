import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory, SlotWithItem } from '../../typings';
import InventorySlot from './InventorySlot';
import { getCraftItemCount, getItemCount, getItemUrl, getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';
import { Locale } from '../../store/locale';
import { Items } from '../../store/items';
import Fade from '../utils/transitions/Fade';

const PAGE_SIZE = 30;

const InventoryGrid: React.FC<{ inventory: Inventory; inv: string }> = ({ inventory, inv }) => {
  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );

  const [page, setPage] = useState(0);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);
  const [closed, setClosed] = useState<string[]>([]);
  const [query, setQuery] = useState<{ [key: string]: string }>({});

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);

  // CRAFTING
  const [craftItem, setCraftItem] = useState<SlotWithItem | undefined>();
  const ingredients = useMemo(() => {
    if (!craftItem || !craftItem.ingredients) return null;
    return Object.entries(craftItem.ingredients).sort((a, b) => a[1] - b[1]);
  }, [craftItem]);

  return (
    <>
      {inventory.type !== 'crafting' && inventory.type !== 'shop' && (
        <div
          className={`bg-black/70 rounded-lg border border-neutral-500 w-[540px] absolute top-1/2 ${
            inv === 'left' ? 'left-[16%]' : 'left-[84%]'
          } p-5`}
          style={{
            pointerEvents: isBusy ? 'none' : 'auto',
            transform: `translate(-50%, -50%) perspective(1000px) rotateY(${inv === 'left' ? '12deg' : '-12deg'})`,
          }}
        >
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-5 text-white font-medium">
              <p className="text-lg">{inventory.label}</p>
              <div className="flex items-center gap-1">
                <span className="material-symbols-outlined">weight</span>
                {inventory.maxWeight && (
                  <p>
                    {weight / 1000}/{inventory.maxWeight / 1000}kg
                  </p>
                )}
              </div>
            </div>
            <div className="text-white flex items-center gap-1">
              <input
                type="text"
                className="bg-black/65 text-white focus:outline-none rounded px-2 py-1.5 border border-neutral-500/65 w-[150px]"
                onChange={(e) => setQuery((prev) => ({ ...prev, [inv]: e.target.value }))}
              />
              <span className="material-symbols-outlined">search</span>
              <span
                className={`material-symbols-outlined cursor-pointer ${
                  closed.includes(inv) ? 'rotate-180' : 'rotate-0'
                } transition-all duration-300`}
                onClick={() => {
                  setClosed((prev) => (prev.includes(inv) ? prev.filter((id) => id !== inv) : [...prev, inv]));
                }}
              >
                keyboard_arrow_up
              </span>
            </div>
          </div>
          <div className="bg-black/65 w-full h-2 my-2 rounded-full border border-neutral-600 overflow-hidden">
            <div
              className="bg-lime-500 h-full w-2"
              style={{ width: `${inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0}%` }}
            ></div>
          </div>
          <AccordionSection open={!closed.includes(inv)}>
            <div className="grid grid-cols-4 h-[400px] overflow-y-scroll pr-1 gap-2">
              {inventory.items.slice(0, (page + 1) * PAGE_SIZE).map((item, index) => (
                <InventorySlot
                  key={`${inventory.type}-${inventory.id}-${item.slot}`}
                  item={item}
                  ref={index === (page + 1) * PAGE_SIZE - 1 ? ref : null}
                  inventoryType={inventory.type}
                  inventoryGroups={inventory.groups}
                  inventoryId={inventory.id}
                  query={query[inv]}
                />
              ))}
            </div>
          </AccordionSection>
        </div>
      )}
      {inventory.type === 'crafting' && (
        <div
          className={`font-[Oswald] bg-black/70 rounded-lg border border-neutral-500 w-[540px] absolute top-1/2 ${
            inv === 'left' ? 'left-[16%]' : 'left-[84%]'
          } p-5`}
          style={{
            pointerEvents: isBusy ? 'none' : 'auto',
            transform: `translate(-50%, -50%) perspective(1000px) rotateY(${inv === 'left' ? '12deg' : '-12deg'})`,
          }}
        >
          <p className='text-neutral-400 font-bold'>{(Locale.recipes || 'Recipes').toUpperCase()}</p>
          <div className='relative my-3'>
            <input type="text" className='bg-black/65 focus:outline-none w-full px-5 py-2 rounded-md border border-neutral-600 text-white font-[Inter]' />
            <span className="material-symbols-outlined absolute top-1/2 right-5 -translate-y-1/2 text-white pointer-events-none">search</span>
          </div>
          <div className='grid grid-cols-4 gap-3'>
            {inventory.items.slice(0, (page + 1) * PAGE_SIZE).map((item, index) => (
              <div className={`relative w-[120px] h-[120px] border border-transparent crafting-slot ${craftItem === item ? 'bg-lime-950/50' : 'bg-black/50'} rounded-lg
                cursor-pointer hover:bg-lime-950/50 group`} 
                onClick={() => setCraftItem(item as SlotWithItem)}
                data-active={craftItem === item ? 'true' : 'false'}
                style={{ 
                  borderColor: craftItem === item ? '#84cc16' : undefined
                }}
                key={`crafting-slot-${index}`}
              >
                <img
                  src={`${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`}
                  className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-0"
                  alt={item.name}
                />
                <p className="absolute text-white w-full bottom-2 font-semibold z-10 text-sm text-center font-[Inter]">
                  {item.metadata?.label ? item.metadata.label : Items[item.name as string]?.label || item.name}
                </p>
                <p className={`text-white absolute top-1 right-1 ${craftItem === item ? 'bg-lime-950/50' : 'bg-neutral-500/50'} rounded-full px-2 border 
                  ${craftItem === item ? 'border-lime-500' : 'border-transparent'} group-hover:bg-lime-950 group-hover:border-lime-500
                duration-200`}>{getCraftItemCount(item) === 'infinity' ? <i className='fa-solid fa-infinity'></i> : getCraftItemCount(item)}</p>
              </div>
            ))}
          </div>
          <div className='border-b border-neutral-700 my-3'></div>
          <div className='h-[300px] relative'>
            <Fade in={craftItem === undefined}>
              <div className='absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex items-center justify-center flex-col text-3xl w-full gap-3 text-white'>
                <p>{(Locale.select_item_to_craft || 'Select an item to craft').toUpperCase()}</p>
                <i className="fa-regular fa-square-plus"></i>
              </div>
            </Fade>
            <Fade in={craftItem !== undefined}>
              <>
                {craftItem !== undefined && (
                  <>
                    <div className='flex items-center justify-between'>
                      <p className='uppercase text-white text-3xl'>{craftItem.metadata?.label ? craftItem.metadata.label : Items[craftItem.name as string]?.label || craftItem.name}</p>
                      <div className='flex gap-1 flex-col'>
                        <p className='text-neutral-400 text-[15px]'>{(Locale.quantity || 'Quantity').toUpperCase()}</p>
                        <p className='text-white text-xl'>{craftItem.count}</p>
                      </div>
                    </div>
                    <div className='flex items-center gap-3'>
                      <p className='text-neutral-400 text-xl'>{(Locale.crafting_time || 'Crafting Time').toUpperCase()}:</p>
                      <p className='text-white text-xl bg-lime-950/50 border border-lime-600 rounded-lg px-3 py-1.5'>{(craftItem.duration !== undefined ? craftItem.duration : 3000) / 1000}s</p>
                    </div>
                    <p className='text-neutral-400 mt-3 font-[Inter]'>{(Locale.item_required || 'Items required').toUpperCase()}</p>
                    <div className='mt-3 flex items-center gap-4'>
                      {ingredients && ingredients.map((ingredient) => {
                        const [item, count] = [ingredient[0], ingredient[1]];
                        return (
                          <div className={`w-[80px] h-[75px] relative crafting-slot pointer-events-none rounded-lg
                            ${getItemCount(item) >= count ? 'bg-lime-950/50' : 'bg-black/65'}`} 
                            key={`ingredient-${item}`}
                            data-active={getItemCount(item) >= count ? 'true' : 'false'}
                          >
                            <img src={item ? getItemUrl(item) : 'none'} alt="item-image" className="w-[45px] h-[45px] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" />
                            <p className='text-white text-sm absolute bottom-0.5 right-1'>{getItemCount(item)}/{count}</p>
                          </div>
                        );
                      })}
                    </div>
                  </>
                )}
              </>
            </Fade>
          </div>
          <div className='border-b border-neutral-700 my-3'></div>
        </div>
      )}
    </>
  );
};

export default InventoryGrid;

const AccordionSection: React.FC<{ open: boolean; children: any }> = ({ open, children }) => {
  const contentRef = useRef<HTMLDivElement>(null);
  const [maxHeight, setMaxHeight] = useState(() => (open ? 'auto' : '0px'));

  useEffect(() => {
    const el = contentRef.current;
    if (!el) return;

    const updateHeight = () => {
      if (open) {
        setMaxHeight(`${el.scrollHeight}px`);
        setTimeout(() => setMaxHeight('auto'), 300);
      } else {
        setMaxHeight('0px');
      }
    };

    const timeout = setTimeout(updateHeight, 50);
    return () => clearTimeout(timeout);
  }, [open, children]);

  useEffect(() => {
    const el = contentRef.current;
    if (!el) return;

    const resizeObserver = new ResizeObserver(() => {
      if (open) {
        setMaxHeight('auto');
      }
    });

    resizeObserver.observe(el);
    return () => resizeObserver.disconnect();
  }, [open]);

  return (
    <div
      style={{
        maxHeight,
        opacity: open ? 1 : 0,
        overflow: 'hidden',
        transition: 'all 0.3s',
      }}
    >
      <div ref={contentRef}>{children}</div>
    </div>
  );
};
