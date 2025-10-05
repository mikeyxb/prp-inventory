import { CaseReducer, PayloadAction } from '@reduxjs/toolkit';
import { getItemData, itemDurability } from '../helpers';
import { Items } from '../store/items';
import { Inventory, InventoryType, Slot, State } from '../typings';

const parseNumber = (value: unknown): number | undefined => {
  if (typeof value === 'number') return value;
  if (typeof value === 'string') {
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : undefined;
  }
  return undefined;
};

const parseContainerSize = (size: unknown): [number | undefined, number | undefined] => {
  if (!size) return [undefined, undefined];

  if (Array.isArray(size)) {
    const [slots, weight] = size as Array<unknown>;
    return [parseNumber(slots), parseNumber(weight)];
  }

  if (typeof size === 'object') {
    const entries = Object.keys(size as Record<string, unknown>)
      .map((key) => ({ index: Number(key), value: (size as Record<string, unknown>)[key] }))
      .filter((entry) => Number.isFinite(entry.index))
      .sort((a, b) => a.index - b.index)
      .map((entry) => entry.value);

    const [slots, weight] = entries;
    return [parseNumber(slots), parseNumber(weight)];
  }

  return [undefined, undefined];
};

const findContainerSlot = (items: Slot[]): Slot | undefined => {
  if (!items) return undefined;
  return items.find((item) => item?.metadata?.container);
};

export const updateContainerState = (state: State) => {
  const containerSlot = findContainerSlot(state.leftInventory?.items ?? []);

  if (!containerSlot?.name) {
    state.containerSlot = undefined;
    state.containerInfo = undefined;
    return;
  }

  const [slots, maxWeight] = parseContainerSize(containerSlot.metadata?.size);
  const currentWeight = parseNumber(containerSlot.metadata?.weight);
  const id = typeof containerSlot.metadata?.container === 'string' ? containerSlot.metadata.container : undefined;
  const label =
    containerSlot.metadata?.label || (containerSlot.name && Items[containerSlot.name]?.label) || containerSlot.name;

  state.containerSlot = containerSlot;
  state.containerInfo = {
    id,
    label,
    slots,
    maxWeight,
    currentWeight,
  };

  if (id && state.containerInventory.type === InventoryType.CONTAINER && state.containerInventory.id === id) {
    state.containerInfo.maxWeight =
      parseNumber(state.containerInventory.maxWeight) ?? state.containerInfo.maxWeight;
  }
};

export const setupInventoryReducer: CaseReducer<
  State,
  PayloadAction<{
    leftInventory?: Inventory;
    rightInventory?: Inventory;
  }>
> = (state, action) => {
  const { leftInventory, rightInventory } = action.payload;
  const curTime = Math.floor(Date.now() / 1000);

  if (leftInventory)
    state.leftInventory = {
      ...leftInventory,
      items: Array.from(Array(leftInventory.slots), (_, index) => {
        const item = Object.values(leftInventory.items).find((item) => item?.slot === index + 1) || {
          slot: index + 1,
        };

        if (!item.name) return item;

        if (typeof Items[item.name] === 'undefined') {
          getItemData(item.name);
        }

        item.durability = itemDurability(item.metadata, curTime);
        return item;
      }),
    };

  if (rightInventory) {
    const hydratedInventory: Inventory = {
      ...rightInventory,
      items: Array.from(Array(rightInventory.slots), (_, index) => {
        const item = Object.values(rightInventory.items).find((item) => item?.slot === index + 1) || {
          slot: index + 1,
        };

        if (!item.name) return item;

        if (typeof Items[item.name] === 'undefined') {
          getItemData(item.name);
        }

        item.durability = itemDurability(item.metadata, curTime);
        return item;
      }),
    };

    if (hydratedInventory.type === InventoryType.CONTAINER) {
      state.containerInventory = hydratedInventory;
    } else {
      state.rightInventory = hydratedInventory;
    }
  }

  updateContainerState(state);

  state.shiftPressed = false;
  state.isBusy = false;
};
