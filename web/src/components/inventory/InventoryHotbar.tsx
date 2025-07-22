import React, { useState } from 'react';
import { getItemUrl, isSlotWithItem } from '../../helpers';
import useNuiEvent from '../../hooks/useNuiEvent';
import { Items } from '../../store/items';
import WeightBar from '../utils/WeightBar';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { Slot, SlotWithItem } from '../../typings';
import SlideUp from '../utils/transitions/SlideUp';
import { getColor } from './InventorySlot';

const InventoryHotbar: React.FC = () => {
  const [hotbarVisible, setHotbarVisible] = useState(false);
  const items = useAppSelector(selectLeftInventory).items.slice(0, 5);

  //stupid fix for timeout
  const [handle, setHandle] = useState<NodeJS.Timeout>();
  useNuiEvent('toggleHotbar', () => {
    if (hotbarVisible) {
      setHotbarVisible(false);
    } else {
      if (handle) clearTimeout(handle);
      setHotbarVisible(true);
      setHandle(setTimeout(() => setHotbarVisible(false), 3000));
    }
  });

  return (
    <SlideUp in={hotbarVisible}>
      <div className="flex items-center justify-center gap-2 w-full absolute bottom-[2vh]">
        {items.map((item) => (
          <div
            className='relative w-[115px] h-[115px] rounded-[3px] border border-transparent item-slot-border
              [background:radial-gradient(#00000050,_#31313150)] hover:[background:radial-gradient(#00000050,_#42424250)]'
            style={
              {
                background:
                  Items[item.name as string]?.rarity !== 'common' ? getColor(Items[item.name as string]?.rarity as string).background : '',
                '--borderColor': getColor(Items[item.name as string]?.rarity as string)?.text || ''
              } as React.CSSProperties
            }
            key={`hotbar-${item.slot}`}
          >
            {isSlotWithItem(item) && (
              <div className='className="p-1.5 text-[#a8a8a8] text-xs relative w-full h-full"'>
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
                {item?.durability !== undefined && (
                  <div className="absolute h-1 w-full bottom-0 left-0">
                    <div className="h-full"
                      style={{ backgroundColor: getColor(Items[item.name as string]?.rarity as string).text, width: `${item.durability}%` }}
                    ></div>
                  </div>
                )}            
              </div>
            )}
          </div>
        ))}
      </div>
    </SlideUp>
  );
};

export default InventoryHotbar;
