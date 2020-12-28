import axios from 'axios';

export default {
  fetchData(obj) {
    const url = new URL('http://localhost:4001/');
    url.pathname = obj.pathname;

    const axiosConfig = {
      method: obj.method,
      url: url.href,
      headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') }
    };
      
    if (obj.data) {
      axiosConfig.data = obj.data;
    }
  
    axios(axiosConfig)
      .then(() => {
        if (obj.redirectTo) {
          window.location.href = obj.redirectTo;
        }
    })
    .catch(() => {
    });
  }
};
