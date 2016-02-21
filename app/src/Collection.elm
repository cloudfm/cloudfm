module Collection (..) where

import List exposing (..)
import Html exposing (..)
import Html.Attributes exposing (src, href)
import Html.Events exposing (..)
import Signal exposing (Signal, Address)
import Dict
import Artist
import Album
import Stylesheet exposing (id, class, CssClasses(..), CssIds(..))
import Song
import Playlist
import Player
import Router
import Backend exposing(Types(..))


type Action
    = Play Playlist.Model


type alias Model =
    { artists : List Artist.Model
    }


initialModel : Model
initialModel =
  { artists =
      [ { name = "India"
        , albums =
            [ { name = "National Anthem"
              , cover = "http://www.billboard.com/files/styles/gallery_main_well/public/media/Green-Day-American-Idiot-album-covers-billboard-1000x1000.jpg"
              , songs =
                  [ { title = "National Anthem"
                    , url = "http://www.sample-videos.com/audio/mp3/india-national-anthem.mp3"
                    , backend = Http
                    }
                  ]
              }
            ]
        }
      , { name = "Crowd"
        , albums =
            [ { name = "Cheering"
              , cover = "http://www.billboard.com/files/styles/gallery_main_well/public/media/Taylor-Swift-1989-album-covers-billboard-1000x1000.jpg"
              , songs =
                  [ { title = "Cheering"
                    , url = "http://www.sample-videos.com/audio/mp3/crowd-cheering.mp3"
                    , backend = Http
                    }
                  ]
              }
            ]
        }
      , { name = "Wave"
        , albums =
            [ { name = "Waving"
              , cover = "http://www.billboard.com/files/styles/gallery_main_well/public/media/Ohio-Players-Honey-album-covers-billboard-1000x1000.jpg"
              , songs =
                  [ { title = "Waving"
                    , url = "http://www.sample-videos.com/audio/mp3/wave.mp3"
                    , backend = Http
                    }
                  ]
              }
            ]
        }
      , { name = "evancz"
        , albums =
            [ { name = "Elm"
              , cover = "http://www.billboard.com/files/styles/gallery_main_well/public/media/Yeah-Yeah-Yeahs-Its-Blitz-album-covers-billboard-1000x1000.jpg"
              , songs =
                  [ { title = "Elm"
                    , url = "https://www.youtube.com/embed/ZTliDiWDV0k"
                    , backend = YouTube
                    }
                  ]
              }
            ]
        }
      ]
  }


artistView : Address Action -> Artist.Model -> Html
artistView address artist =
  let
    playlist = map (\album -> album.songs) artist.albums
      |> foldr (++) []
  in
  li
    [ class [ ArtistItem ] ]
    [ a [ href ("#collection/" ++ artist.name) ] [ text artist.name ] ]


albumView : Address Action -> Album.Model -> Html
albumView address album =
  li
    [ class [ AlbumItem ], onClick address (Play album.songs) ]
    [ a [ href "#" ] [ img [ class [ AlbumCover ], src album.cover] [ ] ] ]



view : Address Action -> Model -> Router.Payload -> Html
view address model payload =
  let
    -- FIXME there probably is a better way to do this
    selectedArtist = Dict.get "artist" payload.params
    predicate = (\artist -> (Maybe.withDefault artist.name selectedArtist) == artist.name)
    albums = filter predicate  model.artists
        |> map (\artist -> artist.albums)
        |> foldr (++) []
  in
    div
      [ id Collection ]
      [ ul [ id CollectionArtists ] (map (artistView address) model.artists)
      , ul [ id CollectionAlbums ] (map (albumView address) albums)
      ]