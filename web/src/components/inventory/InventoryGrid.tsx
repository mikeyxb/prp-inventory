import React, { useEffect, useMemo, useRef, useState } from 'react';
import { CraftSlot, Inventory, Slot, SlotWithItem } from '../../typings';
import InventorySlot from './InventorySlot';
import {
  canCraftItem,
  getCraftItemCount,
  getItemCount,
  getItemUrl,
  getTotalWeight,
  useCurrentTime,
} from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';
import { Locale } from '../../store/locale';
import { Items } from '../../store/items';
import Fade from '../utils/transitions/Fade';
import CircularProgress from './CircularProgress';
import { onCraft } from '../../dnd/onCraft';

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
  const [craftQuery, setCraftQuery] = useState('');
  const [craftItem, setCraftItem] = useState<SlotWithItem | undefined>();
  const ingredients = useMemo(() => {
    if (!craftItem || !craftItem.ingredients) return null;
    return Object.entries(craftItem.ingredients).sort((a, b) => a[1] - b[1]);
  }, [craftItem]);
  const [countToCraft, setCountToCraft] = useState<number>(1);
  const [craftQueue, setCraftQueue] = useState<CraftSlot[]>([]);

  useEffect(() => {
    // Reset count to craft
    setCountToCraft(1);
  }, [craftItem, craftQueue]);

  const reserved = useMemo(() => {
    const reservedMap: { [key: string]: number } = {};
    craftQueue.forEach((craft) => {
      if (!craft.ingredients) return;
      Object.entries(craft.ingredients).forEach(([name, count]) => {
        reservedMap[name] = (reservedMap[name] || 0) + count * craft.craftCount;
      });
    });
    return reservedMap;
  }, [craftQueue]);

  const now = useCurrentTime();

  useEffect(() => {
    if (craftQueue.length === 0) return;
    const interval = setInterval(() => {
      const current = craftQueue[0];
      if (!current) return;
      const duration = current.duration ?? 3000;
      const timePassed = Date.now() - (current.startedAt ?? Date.now());
      if (timePassed >= duration) {
        onCraft(current);
        setCraftQueue((prev) => {
          const [, ...rest] = prev;
          if (rest.length > 0) rest[0] = { ...rest[0], startedAt: Date.now() };
          return rest;
        });
      }
    }, 1000);
    return () => clearInterval(interval);
  }, [craftQueue]);

  const filteredCraftItems = useMemo(() => {
    return inventory.items.slice(0, (page + 1) * PAGE_SIZE).filter((item) => {
      const label = item.metadata?.label ?? Items[item.name as string]?.label ?? item.name ?? '';
      return label.toLowerCase().includes(craftQuery.toLowerCase());
    });
  }, [inventory.items, page, craftQuery]);

  const filteredInventoryItems = useMemo(() => {
    return inventory.items.slice(0, (page + 1) * PAGE_SIZE).filter((item) => {
      const label = item.metadata?.label ?? Items[item.name as string]?.label ?? item.name ?? '';
      return label.toLowerCase().includes(craftQuery.toLowerCase());
    });
  }, [inventory.items, page, query, inv]);

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
              {filteredInventoryItems.map((item, index) => (
                <InventorySlot
                  key={`${inventory.type}-${inventory.id}-${item.slot}`}
                  item={item}
                  ref={index === filteredInventoryItems.length - 1 ? ref : null}
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
          <p className="text-neutral-400 font-[Inter]">{(Locale.recipes || 'Recipes').toUpperCase()}</p>
          <div className="relative my-3">
            <input
              type="text"
              className="bg-black/65 focus:outline-none w-full px-5 py-2 rounded-md border border-neutral-600 text-white font-[Inter]"
              onChange={(e) => setCraftQuery(e.target.value)}
            />
            <span className="material-symbols-outlined absolute top-1/2 right-5 -translate-y-1/2 text-white pointer-events-none">
              search
            </span>
          </div>

          <div className="grid grid-cols-4 gap-3">
            {filteredCraftItems.length === 0 ? (
              <p className="col-span-4 text-white text-2xl text-center py-5">
                {(Locale.no_items_found || 'No items found').toUpperCase()}
              </p>
            ) : (
              filteredCraftItems.map((item, index) => (
                <div
                  className={`relative w-[120px] h-[120px] border border-transparent crafting-slot ${
                    craftItem === item ? 'bg-lime-950/50' : 'bg-black/50'
                  } rounded-lg cursor-pointer hover:bg-lime-950/50 group`}
                  onClick={() => setCraftItem(item as SlotWithItem)}
                  data-active={craftItem === item ? 'true' : 'false'}
                  style={{
                    borderColor: craftItem === item ? '#84cc16' : undefined,
                  }}
                  key={`crafting-slot-${index}`}
                >
                  <img
                    src={`${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`}
                    className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-0"
                    alt={item.name}
                  />
                  <p className="absolute text-white w-full bottom-2 font-semibold z-10 text-sm text-center font-[Inter]">
                    {item.metadata?.label || Items[item.name as string]?.label || item.name}
                  </p>
                  <p
                    className={`text-white absolute top-1 right-1 ${
                      craftItem === item ? 'bg-lime-950/50' : 'bg-neutral-500/50'
                    } rounded-full px-2 border ${
                      craftItem === item ? 'border-lime-500' : 'border-transparent'
                    } group-hover:bg-lime-950 group-hover:border-lime-500 duration-200`}
                  >
                    {getCraftItemCount(item, reserved) === 'infinity' ? (
                      <i className="fa-solid fa-infinity"></i>
                    ) : (
                      getCraftItemCount(item, reserved)
                    )}
                  </p>
                </div>
              ))
            )}
          </div>

          <div className="border-b border-neutral-700 my-3"></div>

          <div className={`relative ${!craftItem ? 'h-[300px]' : ''}`}>
            <Fade in={!craftItem}>
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex items-center justify-center flex-col text-3xl w-full gap-3 text-white">
                <p>{(Locale.select_item_to_craft || 'Select an item to craft').toUpperCase()}</p>
                <i className="fa-regular fa-square-plus"></i>
              </div>
            </Fade>

            <Fade in={!!craftItem}>
              {craftItem && (
                <>
                  {/* Header */}
                  <div className="flex items-center justify-between">
                    <p className="uppercase text-white text-3xl">
                      {craftItem.metadata?.label || Items[craftItem.name]?.label || craftItem.name}
                    </p>
                    <div className="flex gap-1 flex-col">
                      <p className="text-neutral-400 text-[15px]">{(Locale.quantity || 'Quantity').toUpperCase()}</p>
                      <p className="text-white text-xl">{craftItem.count}</p>
                    </div>
                  </div>

                  {/* Craft time */}
                  <div className="flex items-center gap-3 mt-2">
                    <p className="text-neutral-400 text-xl">
                      {(Locale.crafting_time || 'Crafting Time').toUpperCase()}:
                    </p>
                    <p className="text-white text-xl bg-lime-950/50 border border-lime-600 rounded-lg px-3 py-1.5">
                      {(craftItem.duration ?? 3000) / 1000}s
                    </p>
                  </div>

                  {/* Ingredients */}
                  <p className="text-neutral-400 mt-4 font-[Inter]">
                    {(Locale.item_required || 'Items required').toUpperCase()}
                  </p>
                  <div className="mt-3 flex items-center gap-4 flex-wrap">
                    {ingredients && ingredients.length > 0 ? (
                      ingredients.map(([item, count]) => {
                        const available = getItemCount(item) - (reserved[item] || 0);
                        const hasEnough = available >= count;

                        return (
                          <div
                            key={`ingredient-${item}`}
                            className={`w-[80px] h-[75px] relative crafting-slot rounded-lg pointer-events-none ${
                              hasEnough ? 'bg-lime-950/50' : 'bg-black/65'
                            }`}
                            data-active={hasEnough ? 'true' : 'false'}
                          >
                            <img
                              src={item ? getItemUrl(item) : 'none'}
                              alt="item-image"
                              className="w-[45px] h-[45px] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
                            />
                            <p className="text-white text-sm absolute bottom-0.5 right-1">
                              {available}/{count}
                            </p>
                          </div>
                        );
                      })
                    ) : (
                      <p className="text-white text-xl">
                        {(Locale.no_items_required || 'No items required').toUpperCase()}
                      </p>
                    )}
                  </div>

                  {/* Controls */}
                  <div className="mt-10 flex items-center h-[80px] gap-5">
                    {/* Quantity Input */}
                    <div className="font-[Inter] flex flex-col gap-2">
                      <p className="text-neutral-400 text-sm">{(Locale.quantity || 'Quantity').toUpperCase()}</p>
                      <div className="text-white flex items-center justify-center gap-2 bg-black/65 w-[150px] py-3 rounded-2xl border border-neutral-600">
                        <i
                          className="fa-solid fa-minus text-sm cursor-pointer hover:text-white/50 duration-200"
                          onClick={() => setCountToCraft((prev) => Math.max(prev - 1, 1))}
                        />
                        <input
                          type="text"
                          className="bg-transparent focus:outline-none w-[50px] text-center text-xl"
                          value={countToCraft}
                          onChange={(e) => {
                            const max = getCraftItemCount(craftItem);
                            const val = Number(e.target.value);
                            setCountToCraft(() => {
                              if (isNaN(val)) return 1;
                              if (max === 'infinity') return val;
                              return Math.min(val, max as number);
                            });
                          }}
                        />
                        <i
                          className="fa-solid fa-plus text-sm cursor-pointer hover:text-white/50 duration-200"
                          onClick={() => {
                            const max = getCraftItemCount(craftItem, reserved);
                            const maxCount = max === 'infinity' ? Number.MAX_SAFE_INTEGER : max;
                            setCountToCraft((prev) => Math.min(prev + 1, maxCount));
                          }}
                        />
                      </div>
                    </div>

                    {/* Craft Button */}
                    <button
                      className="bg-black/65 text-white w-full h-full text-lg rounded-2xl border border-neutral-600 hover:border-lime-600 hover:bg-lime-950/50 duration-200"
                      style={{
                        pointerEvents: canCraftItem(craftItem, inventory.type, reserved) ? 'auto' : 'none',
                        opacity: canCraftItem(craftItem, inventory.type, reserved) ? 1 : 0.5,
                      }}
                      onClick={() =>
                        setCraftQueue((prev) => [
                          ...prev,
                          {
                            ...craftItem,
                            craftCount: countToCraft,
                            startedAt: prev.length === 0 ? Date.now() : undefined,
                          },
                        ])
                      }
                    >
                      {(Locale.add_to_queue || 'Add to queue').toUpperCase()}
                    </button>
                  </div>
                </>
              )}
            </Fade>
          </div>

          <div className="border-b border-neutral-700 my-3"></div>
          <p className="font-[Inter] text-neutral-400">{(Locale.queue || 'Queue').toUpperCase()}</p>
          {craftQueue.length === 0 ? (
            <p className="text-neutral-400 text-lg my-3 opacity-75">{Locale.queue_empty || 'The queue is empty.'}</p>
          ) : (
            <div className="mt-3 flex gap-3 overflow-x-auto w-full flex-nowrap pb-3">
              {craftQueue.map((craft, index) => {
                const isActive = index === 0 && !!craft.startedAt;
                const duration = craft.duration ?? 3000;
                const started = craft.startedAt ?? now;
                const progress = isActive ? Math.min((now - started) / duration, 1) : 0;

                const label = craft.metadata?.label ?? Items[craft.name]?.label ?? craft.name;

                const handleRemove = () => {
                  setCraftQueue((prev) => {
                    const filtered = prev.filter((_, i) => i !== index);
                    if (index === 0 && filtered.length > 0 && !filtered[0].startedAt) {
                      filtered[0] = { ...filtered[0], startedAt: Date.now() };
                    }
                    return filtered;
                  });
                };

                return (
                  <div
                    key={`crafting-query-${index}`}
                    className="relative flex-shrink-0 w-[120px] h-[120px] border border-neutral-600 bg-black/50 rounded-lg"
                  >
                    {/* Item Image */}
                    <img
                      src={getItemUrl(craft)}
                      className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-0"
                      alt={craft.name}
                    />

                    {/* Label + Count */}
                    <p className="absolute text-white top-1 left-2 font-semibold z-10 text-[13px] font-[Inter] w-2/3 truncate">
                      {label}
                    </p>
                    <p className="absolute text-white top-1.5 right-2 z-10 text-xs font-[Inter]">x{craft.craftCount}</p>

                    {/* Progress Circle */}
                    {isActive && (
                      <div className="absolute bottom-2 left-2 z-10">
                        <CircularProgress progress={progress} />
                      </div>
                    )}

                    {/* Remove Button */}
                    <i
                      className="fa-regular fa-circle-xmark absolute bottom-2 right-2 text-neutral-500 cursor-pointer hover:text-neutral-400 duration-200"
                      onClick={handleRemove}
                    />
                  </div>
                );
              })}
            </div>
          )}
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
