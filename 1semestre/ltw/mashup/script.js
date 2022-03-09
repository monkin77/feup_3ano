const $ = (selector) => document.querySelector(selector);

const imgMap = {
  SKC: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Gnome-weather-clear.svg/48px-Gnome-weather-clear.svg.png",
  FEW: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Gnome-weather-few-clouds.svg/48px-Gnome-weather-few-clouds.svg.png",
  SCT: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Gnome-weather-overcast.svg/48px-Gnome-weather-overcast.svg.png",
  BKN: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Gnome-weather-severe-alert.svg/48px-Gnome-weather-severe-alert.svg.png",
  OVC: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Gnome-weather-storm.svg/48px-Gnome-weather-storm.svg.png",
};

const changeImage = (weatherCode) => {
  const img = $("img[id=weatherImg]"); // Get img
  const id = weatherCode ?? $("select[name=weather").value; // Get value from selector

  img.src = imgMap[id];
};

/**
 *
 * @param {*} coords {north, south, east, west}
 */
const getWeatherFromCoords = async (coords = {}) => {
  const { north, south, east, west } = coords;
  const url = `http://api.geonames.org/weatherJSON?formatted=true&north=${north}&south=${south}&east=${east}&west=${west}&username=twlab&style=full`;

  let res = await fetch(url);

  res = await res.json();
  const observations = res.weatherObservations;

  for (let observation of observations) {
    if (observation.cloudsCode) {
      const weatherCode = observation.cloudsCode;
      console.log("Fetched weather code:", weatherCode);
      changeImage(weatherCode);
      break;
    }
  }
};

getWeatherFromCoords({ north: 41.3, south: 41.0, east: -8.5, west: -8.7 });

getCityWeather = async (cityName) => {
  const url = `http://api.geonames.org/searchJSON?formatted=true&q=${cityName}&lang=pt&username=twlab&style=full`;

  let res = await fetch(url);
  res = await res.json();
  console.log("res:", res);

  const coords = res.geonames[0].bbox;
  await getWeatherFromCoords(coords);
};
