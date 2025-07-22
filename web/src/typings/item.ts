export type ItemData = {
  name: string;
  label: string;
  stack: boolean;
  usable: boolean;
  close: boolean;
  count: number;
  rarity?: 'common' | 'uncommon' | 'rare' | 'epic' | 'legendary'
  description?: string;
  buttons?: string[];
  ammoName?: string;
  image?: string;
};
