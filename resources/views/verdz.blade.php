<!DOCTYPE html>
<html lang="ar">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="icon" href="{{ asset('favicon.ico') }}" />
  <title>VerDZ</title>

  <link rel="stylesheet" type="text/css" href="{{ asset('loader.css') }}" />
  {{-- @ vite(['resources/js/main.js']) --}}


  {{-- <link rel="manifest" href="{{ asset('build/manifest.webmanifest') }}"> --}}
  <meta name="theme-color" content="#ffffff"> <!-- Same as the one in your manifest -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <meta name="apple-mobile-web-app-title" content="Your App Name">
  <meta name="mobile-web-app-capable" content="yes">

</head>

<body>
  <div id="app">
    <div id="loading-bg">
      <div class="loading-logo">
        <img src="{{ asset('verdz.png') }}" alt="" width="200" height="200">
      </div>
      <div class="loading">
        <div class="effect-1 effects"></div>
        <div class="effect-2 effects"></div>
        <div class="effect-3 effects"></div>
      </div>
    </div>
  </div>
  
  <script>
    const loaderColor=localStorage.getItem('theme') == 'dark' ? '#2b2c40' : '#ffffff'; 
    const primaryColor=localStorage.getItem('theme') == 'dark' ? '#9B7D2E' : '#557b50'; 

    if (loaderColor)
    {
      document.documentElement.style.setProperty('--initial-loader-bg', loaderColor)
      document.body.style.backgroundColor = loaderColor;
    }

    if (primaryColor)
      document.documentElement.style.setProperty('--initial-loader-color', primaryColor)

    // if ('serviceWorker' in navigator) {
    //   window.addEventListener('load', () => {
    //     navigator.serviceWorker.register('{{ asset("build/sw.js") }}')
    //       .then(registration => {
    //         console.log('Service Worker registered with scope:', registration.scope);
    //       })
    //       .catch(err => {
    //         console.error('Service Worker registration failed:', err);
    //       });
    //   });
    // }
  </script>
</body>

</html>
