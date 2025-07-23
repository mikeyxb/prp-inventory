import React, { useContext } from 'react';
import { createPortal } from 'react-dom';
import { TransitionGroup } from 'react-transition-group';
import useNuiEvent from '../../hooks/useNuiEvent';
import useQueue from '../../hooks/useQueue';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';
import { SlotWithItem } from '../../typings';
import { Items } from '../../store/items';
import Fade from './transitions/Fade';
import { getColor } from '../inventory/InventorySlot';

interface ItemNotificationProps {
  item: SlotWithItem;
  text: string;
}

export const ItemNotificationsContext = React.createContext<{
  add: (item: ItemNotificationProps) => void;
} | null>(null);

export const useItemNotifications = () => {
  const itemNotificationsContext = useContext(ItemNotificationsContext);
  if (!itemNotificationsContext) throw new Error(`ItemNotificationsContext undefined`);
  return itemNotificationsContext;
};

const ItemNotification = React.forwardRef(
  (props: { item: ItemNotificationProps; style?: React.CSSProperties }, ref: React.ForwardedRef<HTMLDivElement>) => {
    const slotItem = props.item.item;

    return (
      <div
        className="relative w-[115px] h-[115px] border border-transparent item-slot-border font-[Inter]"
        style={
          {
            '--borderColor': getColor(Items[slotItem.name]?.rarity as string).text,
          } as React.CSSProperties
        }
        ref={ref}
      >
        <div className="p-1.5 text-[#a8a8a8] text-xs relative w-full h-full">
          <img
            src={`${slotItem?.name ? getItemUrl(slotItem as SlotWithItem) : 'none'}`}
            className="absolute w-[70px] h-[70px] top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none z-0"
            alt={slotItem.name}
          />

          <div className="relative leading-3 z-10">
            <p className='uppercase text-[10px] font-semibold'>{props.item.text}</p>
            <p className="text-[11px]">
              {slotItem.weight > 0
                ? slotItem.weight >= 1000
                  ? `${(slotItem.weight / 1000).toLocaleString('en-us', {
                      minimumFractionDigits: 1,
                    })}kg `
                  : `${slotItem.weight.toLocaleString('en-us', {
                      minimumFractionDigits: 1,
                    })}g `
                : ''}
            </p>
          </div>

          <div className="absolute text-white text-center w-full bottom-[7px] left-1/2 -translate-x-1/2 font-semibold z-10">{slotItem.metadata?.label || Items[slotItem.name]?.label}</div>
        </div>
      </div>
    );
  }
);

export const ItemNotificationsProvider = ({ children }: { children: React.ReactNode }) => {
  const queue = useQueue<{
    id: number;
    item: ItemNotificationProps;
    ref: React.RefObject<HTMLDivElement>;
  }>();

  const add = (item: ItemNotificationProps) => {
    const ref = React.createRef<HTMLDivElement>();
    const notification = { id: Date.now(), item, ref: ref };

    queue.add(notification);

    const timeout = setTimeout(() => {
      queue.remove();
      clearTimeout(timeout);
    }, 2500);
  };

  useNuiEvent<[item: SlotWithItem, text: string, count?: number]>('itemNotify', ([item, text, count]) => {
    add({ item: item, text: count ? `${Locale[text]} ${count}x` : `${Locale[text]}` });
  });

  return (
    <ItemNotificationsContext.Provider value={{ add }}>
      {children}
      {createPortal(
        <TransitionGroup className="flex justify-center flex-nowrap gap-[2px] absolute bottom-[20vh] left-1/2 w-full -translate-x-1/2">
          {queue.values.map((notification, index) => (
            <Fade key={`item-notification-${index}`}>
              <ItemNotification item={notification.item} ref={notification.ref} />
            </Fade>
          ))}
        </TransitionGroup>,
        document.body
      )}
    </ItemNotificationsContext.Provider>
  );
};
