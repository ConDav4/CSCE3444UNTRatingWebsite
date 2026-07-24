import { createStore } from 'vuex';

export default createStore({
  state: {
    username: 'Guest',
    user:{username:'Guest',guest:true}
  },
  mutations: {
    SET_USERNAME(state, newUsername) {
      state.username = newUsername;
    },
    SET_USER(state, newUser) {
      state.user = newUser;
    },
    CLEAR_USER(state) {
      state.user = {username:'Guest',guest:true};
    }
  },
  actions: {
    updateUsername({ commit }, newUsername) {
      commit('SET_USERNAME', newUsername);
    },
    updateUser({ commit }, newUser) {
      commit('SET_USER', newUser);
    }
  },
  getters: {
    getUsername: (state) => state.username,
    getUser: (state) => state.user
  }
});