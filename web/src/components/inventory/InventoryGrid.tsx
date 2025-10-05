import React, { useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import { AccountType, CraftSlot, DragSource, Inventory, InventoryType, SlotWithItem } from '../../typings';
import InventorySlot, { getColor } from './InventorySlot';
import {
  canCraftItem,
  getCraftItemCount,
  getItemCount,
  getItemUrl,
  getTotalWeight,
  useCurrentTime,
} from '../../helpers';
import { PlayerID, useAppSelector } from '../../store';
import {
  selectContainerInfo,
  selectContainerInventory,
  selectContainerSlot,
} from '../../store/inventory';
import { useIntersection } from '../../hooks/useIntersection';
import { Locale } from '../../store/locale';
import { Items } from '../../store/items';
import Fade from '../utils/transitions/Fade';
import CircularProgress from './CircularProgress';
import { onCraft } from '../../dnd/onCraft';
import { useDrag, useDrop } from 'react-dnd';
import dragSound from '../../assets/sounds/drag.wav';
import { useMergeRefs } from '@floating-ui/react';
import { onBuy } from '../../dnd/onBuy';

const PAGE_SIZE = 30;
const MAX_PANEL_HEIGHT = 800;
const MIN_SECTION_HEIGHT = 200;

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
  const containerInventoryState = useAppSelector(selectContainerInventory);
  const containerSlot = useAppSelector(selectContainerSlot);
  const containerInfo = useAppSelector(selectContainerInfo);
  const [containerClosed, setContainerClosed] = useState(false);
  const panelRef = useRef<HTMLDivElement>(null);
  const playerHeaderRef = useRef<HTMLDivElement>(null);
  const playerGridRef = useRef<HTMLDivElement>(null);
  const containerWrapperRef = useRef<HTMLDivElement>(null);
  const containerHeaderRef = useRef<HTMLDivElement>(null);
  const containerGridRef = useRef<HTMLDivElement>(null);

  const showContainer = useMemo(
    () =>
      inv === 'left' &&
      !!containerSlot &&
      containerInventoryState.type === InventoryType.CONTAINER &&
      containerSlot.metadata?.container === containerInventoryState.id,
    [inv, containerSlot, containerInventoryState]
  );

  useEffect(() => {
    if (!showContainer) {
      setContainerClosed(false);
    }
  }, [showContainer]);

  const containerWeight = useMemo(
    () => (showContainer ? Math.floor(getTotalWeight(containerInventoryState.items) * 1000) / 1000 : 0),
    [showContainer, containerInventoryState.items]
  );

  const containerMaxWeight = showContainer
    ? containerInfo?.maxWeight ?? containerInventoryState.maxWeight ?? 0
    : 0;

  const containerLabel = useMemo(() => {
    if (!showContainer || !containerSlot) return undefined;
    if (containerInfo?.label) return containerInfo.label;
    if (containerSlot.name) {
      return Items[containerSlot.name]?.label || containerSlot.name;
    }
    return Locale.backpack || 'Backpack';
  }, [showContainer, containerSlot, containerInfo]);

  const containerSlotCount = showContainer ? containerInfo?.slots ?? containerInventoryState.slots : 0;
  const backpackTitle = (Locale.backpack_inventory || Locale.backpack || 'Backpack Inventory').toUpperCase();

  useLayoutEffect(() => {
    const panelEl = panelRef.current;
    const playerGridEl = playerGridRef.current;

    if (!panelEl || !playerGridEl) return;

    const getMarginTop = (element: HTMLElement | null) => {
      if (!element) return 0;
      const margin = window.getComputedStyle(element).marginTop;
      return Number.parseFloat(margin || '0') || 0;
    };

    const getViewportLimit = () => {
      const viewportHeight = typeof window !== 'undefined' ? window.innerHeight : MAX_PANEL_HEIGHT;
      const safeViewport = Math.max(viewportHeight - 160, MIN_SECTION_HEIGHT * 2);
      return Math.min(MAX_PANEL_HEIGHT, safeViewport);
    };

    const updateHeights = () => {
      if (!playerGridRef.current) return;

      const playerHeaderHeight = playerHeaderRef.current?.offsetHeight ?? 0;
      const maxPanelSpace = getViewportLimit();
      let panelAvailable = Math.max(MIN_SECTION_HEIGHT, maxPanelSpace - playerHeaderHeight);

      const shouldShowContainer = showContainer && !containerClosed && containerGridRef.current;

      if (!shouldShowContainer) {
        playerGridRef.current.style.maxHeight = `${panelAvailable}px`;
        if (containerGridRef.current) {
          containerGridRef.current.style.maxHeight = '0px';
        }
        return;
      }

      const containerHeaderHeight = containerHeaderRef.current?.offsetHeight ?? 0;
      const containerMarginTop = getMarginTop(containerWrapperRef.current);

      let availableForGrids = panelAvailable - containerMarginTop - containerHeaderHeight;
      if (availableForGrids < MIN_SECTION_HEIGHT * 2) {
        availableForGrids = MIN_SECTION_HEIGHT * 2;
        panelAvailable = availableForGrids + containerMarginTop + containerHeaderHeight;
      }

      const playerSlots = Math.max(inventory.slots || inventory.items.length || 1, 1);
      const containerSlots = Math.max(
        containerSlotCount || containerInventoryState.slots || containerInventoryState.items.length || 1,
        1
      );

      const totalSlots = playerSlots + containerSlots;
      let playerHeight = Math.round((playerSlots / totalSlots) * availableForGrids);
      let containerHeight = availableForGrids - playerHeight;

      if (playerHeight < MIN_SECTION_HEIGHT) {
        playerHeight = MIN_SECTION_HEIGHT;
        containerHeight = availableForGrids - playerHeight;
      }

      if (containerHeight < MIN_SECTION_HEIGHT) {
        containerHeight = MIN_SECTION_HEIGHT;
        playerHeight = availableForGrids - containerHeight;
      }

      playerGridRef.current.style.maxHeight = `${playerHeight}px`;
      containerGridRef.current!.style.maxHeight = `${containerHeight}px`;
    };

    const scheduleUpdate = () => {
      if (typeof window !== 'undefined') {
        window.requestAnimationFrame(updateHeights);
      } else {
        updateHeights();
      }
    };

    scheduleUpdate();

    const supportsResizeObserver = typeof ResizeObserver !== 'undefined';
    let resizeObserver: ResizeObserver | undefined;

    if (supportsResizeObserver) {
      resizeObserver = new ResizeObserver(scheduleUpdate);
      resizeObserver.observe(panelEl);
      resizeObserver.observe(playerGridEl);
      if (playerHeaderRef.current) resizeObserver.observe(playerHeaderRef.current);
      if (containerHeaderRef.current) resizeObserver.observe(containerHeaderRef.current);
      if (containerWrapperRef.current) resizeObserver.observe(containerWrapperRef.current);
      if (containerGridRef.current) resizeObserver.observe(containerGridRef.current);
    }

    window.addEventListener('resize', scheduleUpdate);

    return () => {
      if (resizeObserver) {
        resizeObserver.disconnect();
      }
      window.removeEventListener('resize', scheduleUpdate);
    };
  }, [
    showContainer,
    containerClosed,
    inventory.items.length,
    inventory.slots,
    containerInventoryState.items.length,
    containerInventoryState.slots,
    containerSlotCount,
  ]);

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

  // console.log('items: ', Items);

  // SHOP
  const [shoppingCart, setShoppingCart] = useState<SlotWithItem[]>([]);
  const [animatedTotal, setAnimatedTotal] = useState(0);

  const actualTotal = shoppingCart.reduce(
    (total, item) => total + (item.price ?? 0) * (item.count || 1),
    0
  );

  useEffect(() => {
    let start: any = null;
    let animationFrameId: number;

    const duration = 500; // ms
    const difference = actualTotal - animatedTotal;

    const step = (timestamp: number) => {
      if (!start) start = timestamp;
      const progress = Math.min((timestamp - start) / duration, 1);
      const currentValue = animatedTotal + difference * progress;
      setAnimatedTotal(currentValue);
      if (progress < 1) {
        animationFrameId = requestAnimationFrame(step);
      }
    };

    animationFrameId = requestAnimationFrame(step);
    return () => cancelAnimationFrame(animationFrameId);
  }, [actualTotal]);


  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({
        isDragging: monitor.isDragging(),
      })      
    }),
    [inventory.type]
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
        setShoppingCart(prev => [...prev, { ...source.item, count: 1 }])
      },
      canDrop: (source) =>
        (source.inventory === 'shop')
    }),
    [inventory.type]
  );

  const connectRef = (element: HTMLDivElement) => drag(drop(element));
  const refs = useMergeRefs([connectRef, ref]);

  const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

  const handleBuy = async (account: AccountType) => {
    for (let i = 0; i < shoppingCart.length; i++) {
      const item = shoppingCart[i];
      onBuy(item, account);
      await delay(250);
    }
  };

  const filteredInventoryItems = useMemo(() => {
    return inventory.items.slice(inv === 'left' ? 9 : 0, (page + 1) * PAGE_SIZE).filter((item) => {
      const label = item.metadata?.label ?? Items[item.name as string]?.label ?? item.name ?? '';
      return label.toLowerCase().includes(craftQuery.toLowerCase());
    });
  }, [inventory.items, page, query, inv]);

  return (
    <>
      {inventory.type !== 'crafting' && inventory.type !== 'shop' && (
        <div
          ref={panelRef}
          className={`bg-black/90 rounded-lg border border-neutral-500 w-[660px] absolute top-1/2 max-h-[800px] overflow-hidden ${
            inv === 'left' ? 'left-[16%]' : 'left-[84%]'
          } p-5 flex flex-col`}
          style={{
            pointerEvents: isBusy ? 'none' : 'auto',
            transform: `translate(-50%, -50%) perspective(1000px) rotateY(${inv === 'left' ? '12deg' : '-12deg'})`,
          }}
        >
          <div ref={playerHeaderRef} className="space-y-2">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-5 text-white font-medium">
                <p className="text-lg">{inventory.type === 'player' && `[${PlayerID[0]}]`} {inventory.label}</p>
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
            <div className="bg-black/65 w-full h-2 rounded-full border border-neutral-600 overflow-hidden">
              <div
                className="bg-[#ff00ff] h-full w-2"
                style={{ width: `${inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0}%` }}
              ></div>
            </div>
          </div>
          <div className="flex-1 min-h-0">
            <AccordionSection open={!closed.includes(inv)}>
              <div
                ref={playerGridRef}
                className="grid grid-cols-5 overflow-y-auto pr-1 gap-2"
              >
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

          {showContainer && (
            <div ref={containerWrapperRef} className="mt-8 flex flex-col min-h-0">
              <div ref={containerHeaderRef} className="space-y-2">
                <div className="flex items-center justify-between text-white">
                  <div className="flex flex-col">
                    <p className="text-neutral-400 text-xs tracking-wide">{backpackTitle}</p>
                    <p className="text-lg font-semibold">{containerLabel}</p>
                    {containerSlotCount ? (
                      <p className="text-neutral-400 text-sm">
                        {(Locale.slots || 'Slots').toUpperCase()}: {containerSlotCount}
                      </p>
                    ) : null}
                  </div>
                  <div className="flex items-center gap-4">
                    <div className="flex items-center gap-1">
                      <span className="material-symbols-outlined">weight</span>
                      <p>
                        {containerMaxWeight
                          ? `${(containerWeight / 1000).toLocaleString('en-us', {
                              minimumFractionDigits: 1,
                            })}/${(containerMaxWeight / 1000).toLocaleString('en-us', {
                              minimumFractionDigits: 1,
                            })}kg`
                          : `${(containerWeight / 1000).toLocaleString('en-us', {
                              minimumFractionDigits: 1,
                            })}kg`}
                      </p>
                    </div>
                    <span
                      className={`material-symbols-outlined cursor-pointer transition-transform duration-300 ${
                        containerClosed ? 'rotate-180' : 'rotate-0'
                      }`}
                      onClick={() => setContainerClosed((prev) => !prev)}
                    >
                      keyboard_arrow_up
                    </span>
                  </div>
                </div>
                <div className="bg-black/65 w-full h-2 rounded-full border border-neutral-600 overflow-hidden">
                  <div
                    className="bg-[#00ffff] h-full w-2"
                    style={{
                      width: `${
                        containerMaxWeight
                          ? Math.min((containerWeight / containerMaxWeight) * 100, 100)
                          : 0
                      }%`,
                    }}
                  ></div>
                </div>
              </div>
              <div className="flex-1 min-h-0">
                <AccordionSection open={!containerClosed}>
                  <div
                    ref={containerGridRef}
                    className="grid grid-cols-5 overflow-y-auto pr-1 gap-2"
                  >
                  {containerInventoryState.items.map((item, index) => (
                    <InventorySlot
                      key={`${containerInventoryState.type}-${containerInventoryState.id}-${item.slot}`}
                      item={item}
                      inventoryType={containerInventoryState.type}
                      inventoryGroups={containerInventoryState.groups}
                      inventoryId={containerInventoryState.id}
                      query={query[inv]}
                    />
                  ))}
                  </div>
                </AccordionSection>
              </div>
            </div>
          )}
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
                    craftItem === item ? 'bg-cyan-950/50' : 'bg-black/50'
                  } rounded-lg cursor-pointer hover:bg-cyan-950/50 group`}
                  onClick={() => setCraftItem(item as SlotWithItem)}
                  data-active={craftItem === item ? 'true' : 'false'}
                  style={{
                    borderColor: craftItem === item ? '#ff00ff' : undefined,
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
                      craftItem === item ? 'bg-cyan-950/50' : 'bg-neutral-500/50'
                    } rounded-full px-2 border ${
                      craftItem === item ? 'border-cyan-500' : 'border-transparent'
                    } group-hover:bg-cyan-950 group-hover:border-cyan-500 duration-200`}
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
                    <p className="text-white text-xl bg-cyan-950/50 border border-cyan-600 rounded-lg px-3 py-1.5">
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
                              hasEnough ? 'bg-cyan-950/50' : 'bg-black/65'
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
                      className="bg-black/65 text-white w-full h-full text-lg rounded-2xl border border-neutral-600 hover:border-cyan-600 hover:bg-cyan-950/50 duration-200"
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
      {inventory.type === 'shop' && (
        <div className={`font-[Inter] absolute top-1/2 ${ inv === 'left' ? 'left-[16%]' : 'left-[84%]' } w-[660px] flex flex-col gap-2`}
        style={{
          pointerEvents: isBusy ? 'none' : 'auto',
          transform: `translate(-50%, -50%) perspective(1000px) rotateY(${inv === 'left' ? '12deg' : '-12deg'})`,
        }}>
          <div className={`bg-black/70 rounded-lg border border-cyan-500 p-5`}>
            <p className='text-white text-lg font-medium'>{inventory.label}</p>
            <div className="grid grid-cols-5 pr-1 gap-2 mt-2 max-h-[440px] overflow-y-scroll">
              {filteredInventoryItems.map((item, index) => {
                const isInCart = shoppingCart.some(shopItem => item.name === shopItem.name);

                const clearedItem = isInCart
                  ? { ...item, name: undefined, count: undefined }
                  : item;
                return (
                  <InventorySlot
                    key={`${inventory.type}-${inventory.id}-${item.slot}`}
                    item={clearedItem}
                    ref={index === filteredInventoryItems.length - 1 ? ref : null}
                    inventoryType={inventory.type}
                    inventoryGroups={inventory.groups}
                    inventoryId={inventory.id}
                    query={query[inv]}
                  />
                )
              })}
            </div>
          </div>
          <div className={`bg-black/70 rounded-lg border border-[#ff00ff] p-5`}>
            <p className='text-white text-lg font-medium'>{(Locale.shopping_cart || 'Shopping Cart')}</p>

            <div className="border-b border-neutral-600 my-5"></div>

            <div className='h-[250px] flex flex-col gap-2 overflow-y-auto pr-1.5' ref={refs}>
              {shoppingCart.length < 1 && (
                <div className='flex items-center justify-center flex-col h-full text-2xl text-neutral-400'>
                  <i className="fa-regular fa-square-plus text-4xl"></i>
                  <p className='font-light'>{(Locale.drag_items || 'Drag shop items here').toUpperCase()}</p>
                </div>
              )}

              {shoppingCart.length > 0 && shoppingCart.map((item, index) => (
                <div 
                  key={`shopping-item-${index}`}
                  className='bg-white/5 border border-neutral-500 rounded-lg flex items-center justify-between px-5 py-3'
                >
                  <img 
                    src={item ? getItemUrl(item) : 'none'}
                    alt="item-image"
                    className='w-[75px] h-[75px]'
                  />
                  <div className='flex flex-col leading-3'>
                    <p
                      className="text-[13px] font-semibold"
                      style={{
                        color:
                          Items[item.name as string]?.rarity === 'common'
                            ? '#ffffff'
                            : getColor(Items[item.name as string]?.rarity as string).text,
                      }}
                    >
                      {Items[item.name as string]?.rarity?.toUpperCase()}
                    </p>
                    <p className="text-white font-semibold text-xl max-w-[150px] break-all">
                      {item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}
                    </p>
                  </div>
                  <div className='flex items-center gap-1 h-5'>
                    <button 
                      className='w-6 h-6 bg-white/20 text-white flex items-center justify-center rounded-sm border border-white/50 duration-200 hover:bg-white/35'
                      onClick={() => setShoppingCart(prev => prev.map((shopItem, i) => i === index ? { ...shopItem, count: Math.max((shopItem.count || 1) - 1, 1) } : shopItem))}
                      disabled={!Items[item.name].stack}
                    >
                      -
                    </button>
                    <input 
                      type="number"
                      className='w-[50px] bg-transparent border border-transparent focus:outline-none focus:border-white text-white text-center font-semibold rounded-md transition-all'
                      value={(item.count || 1)}
                      disabled={!Items[item.name].stack}
                      onChange={(e) => setShoppingCart(prev => prev.map((shopItem, i) => i === index ? { ...shopItem, count: Math.max(Number(e.target.value), 1) } : shopItem))}
                    />
                    <button 
                      className='w-6 h-6 bg-white/20 text-white flex items-center justify-center rounded-sm border border-white/50 duration-200 hover:bg-white/35'
                      disabled={!Items[item.name].stack}
                      onClick={() => setShoppingCart(prev => prev.map((shopItem, i) => i === index ? { ...shopItem, count: (shopItem.count || 1) + 1 } : shopItem))}
                    >
                      +
                    </button>
                  </div>
                  <p className='text-neutral-400 text-lg'>${(item.count || 1) * (item.price || 0)}</p>
                  <i className="hgi hgi-stroke hgi-delete-02 text-white text-2xl cursor-pointer duration-200 hover:text-white/50"
                  onClick={() => setShoppingCart(prev => prev.filter((_, i) => i !== index))}></i>
                </div>
              ))}
            </div>

            <div className="border-b border-neutral-600 my-5"></div>

            <div className='text-white flex items-center justify-between'>
              <p className='text-lg'>{(Locale.total_cost || 'Total Cost').toUpperCase()}</p>
              <p className='font-semibold text-2xl'>${animatedTotal.toLocaleString('en-us', {maximumFractionDigits: 0 })}</p>
            </div>

            <div className='flex items-center justify-end gap-3 mt-3'>
              {( !inventory.accounts || inventory.accounts.length === 0 || inventory.accounts.includes('bank') ) && (
                <button className='text-white flex items-center gap-2 text-xl font-semibold bg-black/50 px-4 py-1.5 rounded-sm border border-neutral-700
                hover:bg-cyan-950/50 hover:border-cyan-600 duration-200'
                onClick={() => handleBuy('bank')}>
                  <i className="hgi hgi-stroke hgi-credit-card"></i>
                  <p>{(Locale.pay_bank || 'Pay Bank')}</p>
                </button>
              )}
              {( !inventory.accounts || inventory.accounts.length === 0 || inventory.accounts.includes('money') ) && (
                <button className='text-white flex items-center gap-2 text-xl font-semibold bg-black/50 px-4 py-1.5 rounded-sm border border-neutral-700
                hover:bg-cyan-950/50 hover:border-cyan-600 duration-200'
                onClick={() => handleBuy('money')}>
                  <i className="hgi hgi-stroke hgi-coins-02"></i>
                  <p>{(Locale.pay_money || 'Pay Cash')}</p>
                </button>
              )}
              {( inventory.accounts?.includes('black_money') ) && (
                <button className='text-white flex items-center gap-2 text-xl font-semibold bg-black/50 px-4 py-1.5 rounded-sm border border-neutral-700
                hover:bg-cyan-950/50 hover:border-cyan-600 duration-200'
                onClick={() => handleBuy('black_money')}>
                  <i className="hgi hgi-stroke hgi-bitcoin-bag"></i>
                  <p>{(Locale.pay_black_money || 'Pay Dirty Cash')}</p>
                </button>
              )}
            </div>
          </div>
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
