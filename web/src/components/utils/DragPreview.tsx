import React, { useRef, useMemo } from 'react';
import { useDragLayer, XYCoord } from 'react-dnd';
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

const subtract = (a: XYCoord, b: XYCoord): XYCoord => ({
  x: a.x - b.x,
  y: a.y - b.y,
});

const calculateParentOffset = (monitor: any): XYCoord => {
  const client = monitor.getInitialClientOffset();
  const source = monitor.getInitialSourceClientOffset();
  if (!client || !source) return { x: 0, y: 0 };
  return subtract(client, source);
};

export const calculatePointerPosition = (monitor: any, childRef: React.RefObject<Element>): XYCoord | null => {
  const offset = monitor.getClientOffset();
  if (!offset) return null;

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

  // Memoizuj item, rarity a farbu
  const item = data?.item;
  const itemMeta = item ? Items[item.name] : undefined;

  const rarity = itemMeta?.rarity || 'common';
  const color = useMemo(() => getColor(rarity).text, [rarity]);

  const label = item?.metadata?.label || itemMeta?.label || item?.name || '';

  // Funkcia formátovania hmotnosti
  const formatWeight = (weight: number) => {
    if (weight <= 0) return '';
    if (weight >= 1000) {
      return `${(weight / 1000).toLocaleString('en-us', { minimumFractionDigits: 1 })}kg `;
    }
    return `${weight.toLocaleString('en-us', { minimumFractionDigits: 1 })}g `;
  };

  // Cena zobrazenie
  const priceDisplay = (() => {
    if (!item || item.price === undefined || item.price <= 0) return null;

    if (
      item.currency &&
      item.currency !== 'money' &&
      item.currency !== 'black_money'
    ) {
      return (
        <div className="flex items-center gap-1">
          <img
            src={getItemUrl(item.currency)}
            alt="currency"
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
      );
    }
    return (
      <div className="flex items-center gap-1">
        <p>
          {Locale.$ || '$'}
          {item.price.toLocaleString('en-us')}
        </p>
      </div>
    );
  })();

  if (!isDragging || !currentOffset || !item) return null;

  return (
    <div
      className="relative w-[115px] h-[115px] rounded-[3px] border border-transparent item-slot-border pointer-events-none"
      ref={element}
      style={{
        transform: `translate(${currentOffset.x}px, ${currentOffset.y}px)`,
        '--borderColor': color,
      } as React.CSSProperties}
    >
      <div className="p-1.5 text-[#a8a8a8] text-xs">
        <img
          src={data.image}
          alt={label}
          className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-10"
        />
        <div className="leading-3 font-[350]">
          <p
            className="absolute top-[5px] right-[5px] text-[10px] font-medium"
            style={{ color: rarity === 'common' ? '#ffffff' : color }}
          >
            {rarity.toUpperCase()}
          </p>
          <p>{item.count > 1 ? item.count.toLocaleString('en-us') + 'x' : ''}</p>
          <p className="text-[11px]">{formatWeight(item.weight)}</p>
        </div>
        <p className="absolute text-white w-1/2 bottom-[7px] left-[7px] font-semibold">{label}</p>
        {item.durability !== undefined && (
          <div className="absolute h-1 w-full bottom-0 left-0">
            <div
              className="h-full"
              style={{
                backgroundColor: color,
                width: `${item.durability}%`,
              }}
            />
          </div>
        )}
      </div>
    </div>
  );
};

export default DragPreview;