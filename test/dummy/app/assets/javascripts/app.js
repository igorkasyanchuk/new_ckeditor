function sendData(url, content) {
  var xhr = new XMLHttpRequest();

  xhr.onload = function () {
    // Process our return data
    if (xhr.status >= 200 && xhr.status < 300) {
      // What do when the request is successful
      console.log('success!', xhr);
    } else {
      // What do when the request fails
      console.log('The request failed!');
    }

    // Code that should run regardless of the request status
    console.log('This always runs...');
  };

  xhr.open('PUT', url);
  xhr.setRequestHeader('X-CSRF-Token', document.querySelectorAll('meta[name="csrf-token"]')[0].content);

  data = new FormData();
  data.set("content", content);

  xhr.send(data);
}