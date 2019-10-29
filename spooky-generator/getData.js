const getJSON = require("get-json");

const API_KEY = "your_key_here";

const go = (i) => {
  getJSON(`https://api.themoviedb.org/3/discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=${i}&with_genres=27`, (error, response) => {
    if (error) {
      console.error(error);
    } else {
      for (const m in response["results"]) {
        try {
          console.log(response["results"][m]["overview"]);
        } catch (e) {
          console.error(response);
        }
      }
    }
  });

  if (i < 500) {
    setTimeout(() => {
      go(i + 1)
    }, 500);
  }
};

go(1);
