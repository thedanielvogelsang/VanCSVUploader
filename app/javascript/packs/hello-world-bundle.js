import ReactOnRails from 'react-on-rails';

import HelloWorld from '../bundles/HelloWorld/components/HelloWorld';
import HomeMessage from '../home';
import Accept from '../accept';
import DropZonePlace from '../dropzone';
import Button from '../button';
import Navbar from '../navbar';
import UploadPage from '../upload_page'
// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld, HomeMessage, Accept, DropZonePlace, Button, Navbar, UploadPage
});
