import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory } from '../../typings';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';

const PAGE_SIZE = 30;

const InventoryGrid: React.FC<{ inventory: Inventory, inv: string }> = ({ inventory, inv }) => {
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
  return (
    <>
      <div className={`bg-black/70 rounded-lg border border-neutral-500 w-[540px] absolute top-1/2 ${inv === 'left' ? 'left-[16%]' : 'left-[84%]'} p-5`} 
      style={{ 
        pointerEvents: isBusy ? 'none' : 'auto',
        transform: `translate(-50%, -50%) perspective(1000px) rotateY(${inv === 'left' ? '12deg' : '-12deg'})`
       }}>
        <div className='flex items-center justify-between'>
          <div className='flex items-center gap-5 text-white font-medium'>
            <p className='text-lg'>{inventory.label}</p>
            <div className='flex items-center gap-1'>
              <span className="material-symbols-outlined">weight</span>
              {inventory.maxWeight && (
                <p>
                  {weight / 1000}/{inventory.maxWeight / 1000}kg
                </p>
              )}
            </div>
          </div>
          <div className='text-white flex items-center gap-1'>
            <input type="text" className='bg-black/65 text-white focus:outline-none rounded px-2 py-1.5 border border-neutral-500/65 w-[150px]' 
            onChange={(e) => setQuery((prev) => ({ ...prev, [inv]: e.target.value }))}/>
            <span className="material-symbols-outlined">search</span>
            <span className={`material-symbols-outlined cursor-pointer ${closed.includes(inv) ? 'rotate-180' : 'rotate-0'} transition-all duration-300`} 
            onClick={() => {
              setClosed((prev) => prev.includes(inv) ? prev.filter((id) => id !== inv) : [...prev, inv] );
            }}>keyboard_arrow_up</span>
          </div>
        </div>
        <div className='bg-black/65 w-full h-2 my-2 rounded-full border border-neutral-600 overflow-hidden'>
            <div className='bg-lime-500 h-full w-2' style={{ width: `${inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0}%` }}></div>
        </div>
        <AccordionSection open={!closed.includes(inv)}>
          <div className='grid grid-cols-4 h-[400px] overflow-y-scroll pr-1 gap-2'>
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
    </>
  );
};

export default InventoryGrid;

const AccordionSection: React.FC<{ open: boolean; children: any }> = ({ open, children }) => {
  const contentRef = useRef<HTMLDivElement>(null);
  const [maxHeight, setMaxHeight] = useState(() => (open ? "auto" : "0px"));

  useEffect(() => {
    const el = contentRef.current;
    if (!el) return;

    const updateHeight = () => {
      if (open) {
        setMaxHeight(`${el.scrollHeight}px`);
        setTimeout(() => setMaxHeight("auto"), 300);
      } else {
        setMaxHeight("0px");
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
        setMaxHeight("auto");
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
        overflow: "hidden",
        transition: "all 0.3s",
      }}
    >
      <div ref={contentRef}>{children}</div>
    </div>
  );
};