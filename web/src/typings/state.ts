import { Inventory } from './inventory';
import { Slot } from './slot';

export type State = {
  leftInventory: Inventory;
  rightInventory: Inventory;
  containerInventory: Inventory;
  itemAmount: number;
  shiftPressed: boolean;
  isBusy: boolean;
  additionalMetadata: Array<{ metadata: string; value: string }>;
  containerSlot?: Slot;
  containerInfo?: {
    id?: string;
    label?: string;
    slots?: number;
    maxWeight?: number;
    currentWeight?: number;
  };
  history?: {
    leftInventory: Inventory;
    rightInventory: Inventory;
    containerInventory: Inventory;
  };
};
