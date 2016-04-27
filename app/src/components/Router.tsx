import * as React from "react";
import {StatelessComponent} from "react";
import {Route} from "react-router";
import {App, Settings, TrackList} from "../components";
import {
  Login, Signup, Collection, Discover, BackendsSettings, UserSettings,
  AlbumList,
} from "../containers";
import {Router as ReactRouter, IndexRoute} from "react-router";
import {ReactRouterReduxHistory} from "react-router-redux";

interface RouterProps {
  history: ReactRouterReduxHistory;
};

export const Router: StatelessComponent<RouterProps> = ({history}) => (
  <ReactRouter history={history}>
    <Route path="/" component={App}>
      <Route path="/login" component={Login}/>
      <Route path="/signup" component={Signup} />
      <Route path="/collection" component={Collection}>
        <IndexRoute component={AlbumList}/>
        <Route path="album/:id" component={TrackList}/>
      </Route>
      <Route path="/discover" component={Discover} />
      <Route path="/settings" component={Settings}>
        <IndexRoute component={UserSettings}/>
        <Route path="user" component={UserSettings}/>
        <Route path="backends" component={BackendsSettings}/>
      </Route>
    </Route>
  </ReactRouter>
);
