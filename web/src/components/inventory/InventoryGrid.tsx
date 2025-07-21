import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory } from '../../typings';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';

const PAGE_SIZE = 30;

const InventoryGrid: React.FC<{ inventory: Inventory }> = ({ inventory }) => {
  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );
  const [page, setPage] = useState(0);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);
  return (
    <>
      <div className="bg-black/70 rounded-lg border border-neutral-500 w-[540px] absolute top-1/2 left-[16%] p-5
      [transform:translate(-50%,-50%)_perspective(1000px)_rotateY(12deg)]" style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
        <div className='flex items-center gap-5 text-white font-medium'>
          <p className='text-lg'>{inventory.label}</p>
          <div className='flex items-center gap-3'>
            <i className="fa-solid fa-weight-hanging"></i>
            {inventory.maxWeight && (
              <p>
                {weight / 1000}/{inventory.maxWeight / 1000}kg
              </p>
            )}
          </div>
        </div>
        <div className='bg-black/65 w-full h-2 my-2 rounded-full border border-neutral-600 overflow-hidden'>
            <div className='bg-lime-500 h-full w-2' style={{ width: `${inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0}%` }}></div>
        </div>
        <div className='grid grid-cols-4 h-[400px] overflow-y-scroll pr-1 gap-2'>
          {inventory.items.slice(0, (page + 1) * PAGE_SIZE).map((item, index) => (
            <InventorySlot
              key={`${inventory.type}-${inventory.id}-${item.slot}`}
              item={item}
              ref={index === (page + 1) * PAGE_SIZE - 1 ? ref : null}
              inventoryType={inventory.type}
              inventoryGroups={inventory.groups}
              inventoryId={inventory.id}
            />
          ))}
        </div>
      </div>
    </>
  );
};

export default InventoryGrid;
