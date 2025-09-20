import axios from 'axios';

// Centralized Axios client
// Supports both VITE_BASE_URL (existing usage) and VITE_API_BASE_URL.
// Example value: http://localhost/agrolink/Aizen/backend
export const API_BASE =
  import.meta.env.VITE_BASE_URL ||
  import.meta.env.VITE_API_BASE_URL ||
  'http://localhost/agrolink/Aizen/backend';

const client = axios.create({
  baseURL: `${API_BASE}/controller`,
});

export default client;
