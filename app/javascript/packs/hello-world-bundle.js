import ReactOnRails from 'react-on-rails';

import HelloWorld from '../bundles/HelloWorld/components/HelloWorld';
import HomeMessage from '../home'
import Accept from '../accept'
// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld, HomeMessage, Accept
});
