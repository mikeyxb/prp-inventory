import { isEnvBrowser } from './misc';

interface DebugEvent<T = any> {
  action: string;
  data: T;
  delay?: number;
}

/**
 * Emulates dispatching an event using SendNUIMessage in the lua scripts.
 * This is used when developing in browser
 *
 * @param events - The event you want to cover
 * @param timer - How long until it should trigger (ms)
 */
export const debugData = <P>(events: DebugEvent<P>[], timer = 1000): void => {
  if (import.meta.env.DEV && isEnvBrowser()) {
    events.forEach((event) => {
      const delay = typeof event.delay === 'number' ? event.delay : timer;

      setTimeout(() => {
        window.dispatchEvent(
          new MessageEvent('message', {
            data: {
              action: event.action,
              data: event.data,
            },
          })
        );
      }, delay);
    });
  }
};
