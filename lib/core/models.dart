// Account models.

class Gravatar {
  String hash;

  Gravatar({this.hash});

  Gravatar.fromJSON(Map<String, dynamic> data) {
    this.hash = data['hash'];
  }
}

class Avatar {
  Gravatar gravatar;

  Avatar({this.gravatar});

  Avatar.fromJSON(Map<String, dynamic> data) {
    this.gravatar = new Gravatar.fromJSON(data['gravatar']);
  }
}

class AccountDetail {
  // Account Details
  //
  // https://developers.themoviedb.org/3/account/get-account-details
  Avatar avatar;
  int id;
  String ISO_639_1;
  String ISO_3166_1;
  String name;
  bool includeAdult;
  String username;

  AccountDetail(
      {this.avatar,
      this.id,
      this.ISO_639_1,
      this.ISO_3166_1,
      this.name,
      this.includeAdult,
      this.username});

  AccountDetail.fromJSON(Map<String, dynamic> data) {
    this.avatar = new Avatar.fromJSON(data['avatar']);
    this.id = data['id'];
    this.ISO_639_1 = data['iso_639_1'];
    this.ISO_3166_1 = data['iso_3166_1'];
    this.name = data['name'];
    this.includeAdult = data['include_adult'];
    this.username = data['username'];
  }
}

class MovieList {
  // MovieList Result Object
  //
  // https://developers.themoviedb.org/3/account/get-created-lists
  String description;
  int favoriteCount;
  int id;
  int itemCount;
  String ISO_639_1;
  String listType;
  String name;
  String posterPath;

  MovieList(
      {this.description,
      this.favoriteCount,
      this.id,
      this.itemCount,
      this.ISO_639_1,
      this.listType,
      this.name,
      this.posterPath});

  MovieList.fromJSON(Map<String, dynamic> data) {
    this.description = data['description'];
    this.favoriteCount = data['favoriteCount'];
    this.id = data['id'];
    this.itemCount = data['item_count'];
    this.ISO_639_1 = data['iso_639_1'];
    this.listType = data['list_type'];
    this.name = data['name'];
    this.posterPath = data['poster_path'];
  }
}

abstract class Page {
  int page;
  int totalPages;
  int totalResults;

  Page(this.page, this.totalPages, this.totalResults);
}

class MovieListResponse extends Page {
  // MovieList Response Data
  //
  // https://developers.themoviedb.org/3/account/get-created-lists
  List<MovieList> results;

  MovieListResponse({int page, this.results, int totalPages, int totalResults})
      : super(page, totalPages, totalResults);

  MovieListResponse.fromJSON(Map<String, dynamic> data)
      : super(data['page'], data['total_pages'], data['total_results']) {
    this.results = List<MovieList>.of(
        data['results'].map((item) => new MovieList.fromJSON(item)));
  }
}

class FavoriteMovies extends Page {
  List<Movie> results;

  FavoriteMovies({int page, this.results, int totalPages, int totalResults})
      : super(page, totalPages, totalResults);

  FavoriteMovies.fromJSON(Map<String, dynamic> data)
      : super(data['page'], data['total_pages'], data['total_results']) {
    this.results =
        List<Movie>.of(data['results'].map((item) => new Movie.fromJSON(item)));
  }
}

class Genre {
  int id;
  String name;

  Genre({this.id, this.name});

  Genre.fromJSON(Map<String, dynamic> data) {
    this.id = data["id"];
    this.name = data["name"];
  }
}

class SpokenLanguage {
  String ISO_639_1; // this is named so because this is a specification code;
  String name;

  SpokenLanguage({this.name, this.ISO_639_1});

  SpokenLanguage.fromJSON(Map<String, dynamic> data) {
    this.ISO_639_1 = data["iso_639_1"];
    this.name = data["name"];
  }
}

class ProductionCountry {
  String ISO_3166_1;
  String name;

  ProductionCountry({this.name, this.ISO_3166_1});

  ProductionCountry.fromJSON(Map<String, dynamic> data) {
    this.ISO_3166_1 = data["iso_3166_1"];
    this.name = data["name"];
  }
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({this.id, this.name, this.logoPath, this.originCountry});

  ProductionCompany.fromJSON(Map<String, dynamic> data) {
    this.id = data["id"];
    this.name = data["name"];
    this.logoPath = data["logo_path"];
    this.originCountry = data["origin_country"];
  }
}

class Keyword {
  int id;
  String name;

  Keyword({this.id, this.name});

  Keyword.fromJSON(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
  }
}

class Network {
  String headquarters;
  String homepage;
  int id;
  String name;
  String originCountry;

  Network(
      {this.headquarters,
      this.homepage,
      this.id,
      this.name,
      this.originCountry});

  Network.fromJSON(Map<String, dynamic> data) {
    this.headquarters = data['headquarters'];
    this.homepage = data['homepage'];
    this.id = data['id'];
    this.name = data['name'];
    this.originCountry = data['origin_country'];
  }
}

class NetworkAlternativeName {
  String name;
  String type;

  NetworkAlternativeName({this.name, this.type});

  NetworkAlternativeName.fromJSON(Map<String, dynamic> data) {
    this.name = data['name'];
    this.type = data['type'];
  }
}

class NetworkAlternativeNames {
  int id;
  List<NetworkAlternativeName> results;

  NetworkAlternativeNames({this.id, this.results});

  NetworkAlternativeNames.fromJSON(Map<String, dynamic> data) {
    this.id = data['id'];
    this.results = List<NetworkAlternativeName>.of(
        data['results'].map((val) => NetworkAlternativeName.fromJSON(val)));
  }
}

abstract class Image {
  num aspectRatio;
  String filePath;
  int height;
  num voteAverage;
  num voteCount;
  int width;

  Image(this.aspectRatio, this.filePath, this.height, this.voteAverage,
      this.voteCount, this.width);
}

class Logo extends Image {
  String fileType;

  Logo(
      {num aspectRatio,
      String filePath,
      int height,
      num voteAverage,
      num voteCount,
      num width,
      this.fileType})
      : super(aspectRatio, filePath, height, voteAverage, voteCount, width);

  Logo.fromJSON(Map<String, dynamic> data)
      : super(data['aspect_ratio'], data['file_path'], data['height'],
            data['vote_average'], data['vote_count'], data['width']) {
    this.fileType = data['file_type'];
  }
}

class Person {
  // Person
  //
  // https://developers.themoviedb.org/3/people/get-person-details

  int id;
  String name;
  List<String> alsoKnownAs;
  String birthday;
  String knownForDepartment;
  String deathday;
  int gender;
  String biography;
  num popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbID;
  String homepage;

  Person(
      {this.id,
      this.name,
      this.alsoKnownAs,
      this.birthday,
      this.knownForDepartment,
      this.deathday,
      this.gender,
      this.biography,
      this.popularity,
      this.placeOfBirth,
      this.profilePath,
      this.adult,
      this.imdbID,
      this.homepage});

  Person.fromJSON(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.birthday = data['birthday'];
    this.knownForDepartment = data['known_for_department'];
    this.deathday = data['deathday'];
    this.gender = data['gender'];
    this.biography = data['biography'];
    this.popularity = data['popularity'];
    this.placeOfBirth = data['place_of_birth'];
    this.profilePath = data['profile_path'];
    this.adult = data['adult'];
    this.imdbID = data['imdb_id'];
    this.homepage = data['homepage'];
  }
}

class TVEpisode {
  // TV Show Episode
  //
  // https://developers.themoviedb.org/3/tv-episodes/get-tv-episode-details
  int id;
  String airDate;
  List<Person> crew;
  List<Person> guestStars;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  String stillPath;
  num voteAverage;
  int voteCount;

  TVEpisode(
      {this.id,
      this.airDate,
      this.crew,
      this.guestStars,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  TVEpisode.fromJSON(Map<String, dynamic> data) {
    this.id = data['id'];
    this.airDate = data['air_date'];
    this.crew = data['crew'].map((d) => new Person.fromJSON(d));
    this.guestStars = data['guest_stars'].map((d) => new Person.fromJSON(d));
    this.name = data['name'];
    this.overview = data['overview'];
    this.productionCode = data['production_code'];
    this.seasonNumber = data['season_number'];
    this.stillPath = data['still_path'];
    this.voteAverage = data['vote_average'];
    this.voteCount = data['vote_count'];
  }
}

class TVSeason {
  // TV Show Season
  //
  // https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details

  String hashID;
  String airDate;
  List<TVEpisode> episodes;
  String name;
  String overview;
  int id;
  String posterPath;
  int seasonNumber;
  int episodeCount;

  TVSeason(
      {this.hashID,
      this.airDate,
      this.episodes,
      this.name,
      this.overview,
      this.id,
      this.posterPath,
      this.seasonNumber});

  TVSeason.fromJSON(Map<String, dynamic> data) {
    this.hashID = data["_id"];
    this.airDate = data['air_date'];
    this.episodes = data['episodes'].map((d) => new TVEpisode.fromJSON(d));
    this.name = data['name'];
    this.overview = data['overview'];
    this.posterPath = data['poster_path'];
    this.seasonNumber = data['season_number'];
    this.episodeCount =
        (data['episode_count']) ? data['episode_count'] : this.episodes.length;
  }
}

class TV {
  // TV Show
  //
  // https://developers.themoviedb.org/3/tv/get-tv-details

  int id;
  String backdropPath;
  Person createdBy;
  List<int> episodeRunTime;
  String firstAirDate;
  List<Genre> genres;
  String homepage;
  bool inProduction;
  List<String> languages;
  String lastAirDate;
  TVEpisode lastEpisodeToAir;
  String name;
  TVEpisode nextEpisodeToAir;
  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  num popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<TVSeason> seasons;
  String status;
  String type;
  num voteAverage;
  int voteCount;

  TV(
      {this.id,
      this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.name,
      this.nextEpisodeToAir,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.seasons,
      this.status,
      this.type,
      this.voteAverage,
      this.voteCount});

  TV.toJSON(Map<String, dynamic> data) {
    this.id = data['id'];
    this.backdropPath = data['backdrop_path'];
    this.createdBy = data['created_by'];
    this.episodeRunTime = data['episode_run_time'];
    this.firstAirDate = data['first_air_date'];
    this.genres = data['genres'];
    this.homepage = data['homepage'];
    this.inProduction = data['in_production'];
    this.languages = data['languages'];
    this.lastAirDate = data['last_air_date'];
    this.lastEpisodeToAir = data['last_episode_to_air'];
    this.name = data['name'];
    this.nextEpisodeToAir = data['next_episode_to_air'];
    this.networks = data['networks'].map((d) => new Network.fromJSON(d));
    this.numberOfEpisodes = data['number_of_episodes'];
    this.numberOfSeasons = data['number_of_seasons'];
    this.originCountry = data['origin_country'];
    this.originalLanguage = data['original_language'];
    this.originalName = data['original_originalName'];
    this.overview = data['overview'];
    this.popularity = data['popularity'];
    this.posterPath = data['poster_path'];
    this.productionCompanies = data['production_companies']
        .map((d) => new ProductionCompany.fromJSON(d));
    this.seasons = data['seasons'].map((d) => new TVSeason(d));
    this.status = data['status'];
    this.type = data['type'];
    this.voteAverage = data['vote_average'];
    this.voteCount = data['vote_count'];
  }
}

class Movie {
  // Reference: https://developers.themoviedb.org/3/movies/get-latest-movie
  int id;
  String imdbID;
  bool isAdult;
  String backdropPath;
  dynamic belongsToCollection; // TODO: Have to be sure about this.
  int budget;
  List<Genre> genres;
  String homePage;
  String originalLanguage;
  String originalTitle;
  String overview;
  num popularity; // can be decimal.
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool hasVideo;
  num voteAverage;
  int voteCount;

  Movie(
      {this.id,
      this.imdbID,
      this.isAdult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.hasVideo,
      this.voteAverage,
      this.voteCount});

  Movie.fromJSON(Map<String, dynamic> data) {
    this.id = data["id"];
    this.imdbID = data["imdb_id"];
    this.isAdult = data["adult"];
    this.backdropPath = data["backdrop_path"];
    this.belongsToCollection = data["belongs_to_collection"];
    this.budget = data["budget"];
    this.genres = data["genres"].map((gn) => new Genre.fromJSON(gn));
    this.homePage = data["homepage"];
    this.originalLanguage = data["original_language"];
    this.originalTitle = data["original_title"];
    this.overview = data["overview"];
    this.popularity = data["popularity"];
    this.posterPath = data["poster_path"];
    this.productionCompanies = data["production_companies"]
        .map((pc) => new ProductionCompany.fromJSON(pc));
    this.productionCountries = data["production_countries"]
        .map((pc) => new ProductionCountry.fromJSON(pc));
    this.releaseDate = data["release_date"];
    this.revenue = data["revenue"];
    this.runtime = data["runtime"];
    this.spokenLanguages =
        data["spoken_languages"].map((sp) => new SpokenLanguage.fromJSON(sp));
    this.status = data["status"];
    this.tagline = data["tagline"];
    this.title = data["title"];
    this.hasVideo = data["video"];
    this.voteAverage = data["vote_average"];
    this.voteCount = data["voteCount"];
  }
}
