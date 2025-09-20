// index.jsx or main.jsx (Root component)
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.jsx';
import './index.css';
import { GoogleOAuthProvider } from '@react-oauth/google';
import AdminView from './Components/Admin/Adminview.jsx';

const container = document.getElementById('root');
const root = createRoot(container);

root.render(
  <React.StrictMode>
    <GoogleOAuthProvider clientId={import.meta.env.VITE_GOOGLE_CLIENT_ID}>
      <App />
      {/* <Banner/> */}
      {/* <AdminView/> */}
    </GoogleOAuthProvider>
  </React.StrictMode>
);
