import React, { RefObject, useRef } from 'react';
import { DragLayerMonitor, useDragLayer, XYCoord } from 'react-dnd';
import { DragSource } from '../../typings';
import { getColor } from '../inventory/InventorySlot';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';

interface DragLayerProps {
  data: DragSource;
  currentOffset: XYCoord | null;
  isDragging: boolean;
}

const subtract = (a: XYCoord, b: XYCoord): XYCoord => {
  return {
    x: a.x - b.x,
    y: a.y - b.y,
  };
};

const calculateParentOffset = (monitor: DragLayerMonitor): XYCoord => {
  const client = monitor.getInitialClientOffset();
  const source = monitor.getInitialSourceClientOffset();
  if (client === null || source === null || client.x === undefined || client.y === undefined) {
    return { x: 0, y: 0 };
  }
  return subtract(client, source);
};

export const calculatePointerPosition = (monitor: DragLayerMonitor, childRef: RefObject<Element>): XYCoord | null => {
  const offset = monitor.getClientOffset();
  if (offset === null) {
    return null;
  }

  if (!childRef.current || !childRef.current.getBoundingClientRect) {
    return subtract(offset, calculateParentOffset(monitor));
  }

  const bb = childRef.current.getBoundingClientRect();
  const middle = { x: bb.width / 2, y: bb.height / 2 };
  return subtract(offset, middle);
};

const DragPreview: React.FC = () => {
  const element = useRef<HTMLDivElement>(null);

  const { data, isDragging, currentOffset } = useDragLayer<DragLayerProps>((monitor) => ({
    data: monitor.getItem(),
    currentOffset: calculatePointerPosition(monitor, element),
    isDragging: monitor.isDragging(),
  }));

  return (
    <>
      {isDragging && currentOffset && data.item && (
        <div
          className={`relative w-[115px] h-[115px] rounded-[3px] border border-transparent item-slot-border pointer-events-none
            [background:radial-gradient(#00000050,_#31313150)] hover:[background:radial-gradient(#00000050,_#42424250)]`}
          ref={element}
          style={
            {
              transform: `translate(${currentOffset.x}px, ${currentOffset.y}px)`,
              background: Items[data.item.name]?.rarity !== 'common' ? getColor(Items[data.item.name]?.rarity as string).background : '',
              '--borderColor': getColor(Items[data.item.name]?.rarity as string).text,
            } as React.CSSProperties
          }
        >
          <div className={`p-1.5 text-[#a8a8a8] text-xs`}>
            <img
              src={data.image}
              className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-10"
            />
            <div className="leading-3 font-[350]">
              <p
                className="absolute top-[5px] right-[5px] text-[10px] font-medium"
                style={{
                  color: Items[data.item.name]?.rarity === 'common' ? '#ffffff' : `${getColor(Items[data.item.name]?.rarity as string).text}`,
                }}
              >
                {Items[data.item.name]?.rarity?.toUpperCase()}
              </p>
              <p>{data.item.count > 1 ? data.item.count.toLocaleString('en-us') + `x` : ''}</p>
              <p className="text-[11px]">
                {data.item.weight > 0
                  ? data.item.weight >= 1000
                    ? `${(data.item.weight / 1000).toLocaleString('en-us', {
                        minimumFractionDigits: 1,
                      })}kg `
                    : `${data.item.weight.toLocaleString('en-us', {
                        minimumFractionDigits: 1,
                      })}g `
                  : ''}
              </p>
            </div>
            <p className="absolute text-white w-1/2 bottom-[7px] left-[7px] font-semibold">
              {data.item.metadata?.label ? data.item.metadata.label : Items[data.item.name]?.label || data.item.name}
            </p>
            {data.item.durability !== undefined && (
              <div className="absolute h-1 w-full bottom-0 left-0">
                <div
                  className="h-full"
                  style={{
                    backgroundColor: getColor(Items[data.item.name]?.rarity as string).text,
                    width: `${data.item.durability}%`,
                  }}
                ></div>
              </div>
            )}
            {data.item?.price !== undefined && (
              <div className="absolute z-10">
                {data.item?.currency !== 'money' &&
                data.item.currency !== 'black_money' &&
                data.item.price > 0 &&
                data.item.currency ? (
                  <div className="flex items-center gap-1">
                    <img
                      src={data.item.currency ? getItemUrl(data.item.currency) : 'none'}
                      alt="item-image"
                      style={{
                        imageRendering: '-webkit-optimize-contrast',
                        height: 'auto',
                        width: '2vh',
                        backfaceVisibility: 'hidden',
                        transform: 'translateZ(0)',
                      }}
                    />
                    <p>{data.item.price.toLocaleString('en-us')}</p>
                  </div>
                ) : (
                  <>
                    {data.item.price > 0 && (
                      <div className="flex items-center gap-1">
                        <p>
                          {Locale.$ || '$'}
                          {data.item.price.toLocaleString('en-us')}
                        </p>
                      </div>
                    )}
                  </>
                )}
              </div>
            )}
          </div>
        </div>
      )}
    </>
  );
};

export default DragPreview;
