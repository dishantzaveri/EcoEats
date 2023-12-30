var platform = new H.service.Platform({
  apikey: "cuj0o7HVeJ7R6ylDkWbuOw7MSUZlwS4cM-2CgRuVa-4",
});

var omvService = platform.getOMVService({ path: "v2/vectortiles/core/mc" });
var baseUrl = "https://js.api.here.com/v3/3.1/styles/omv/oslo/japan/";

var style = new H.map.Style(`${baseUrl}normal.day.yaml`, baseUrl);

var omvProvider = new H.service.omv.Provider(omvService, style);
var omvlayer = new H.map.layer.TileLayer(omvProvider, { max: 22 });

var map = new H.Map(document.getElementById("mapContainer"), omvlayer, {
  zoom: 17,
  center: { lat: 35.68026, lng: 139.76744 },
});

var omvService = platform.getOMVService({ path: "v2/vectortiles/core/mc" });
var baseUrl = "https://js.api.here.com/v3/3.1/styles/omv/oslo/japan/";

var style = new H.map.Style(`${baseUrl}normal.day.yaml`, baseUrl);

var omvProvider = new H.service.omv.Provider(omvService, style);
var omvlayer = new H.map.layer.TileLayer(omvProvider, { max: 22 });

var map = new H.Map(document.getElementById("mapContainer"), omvlayer, {
  zoom: 17,
  center: { lat: 35.68026, lng: 139.76744 },
});
