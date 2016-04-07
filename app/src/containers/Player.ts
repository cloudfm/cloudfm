import {connect} from "react-redux";
import {Audio} from "../components";

const mapStateToProps = (state) => {
  if (!state.player.uri) {
    return {src: "" };
  };
  let {backend, owner, id} = state.player.uri;
  return {
    src: `${process.env.SERVER_URL}/v1/tracks/${backend}:${owner}:${id}`,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
  };
};

export const Player = connect(
  mapStateToProps,
  mapDispatchToProps
)(Audio as any);
