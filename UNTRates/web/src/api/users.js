import axios from 'axios';

export const userLogin=(username, password)=>{
    const formData = new FormData();
    formData.append('password', password);
    formData.append('username', username);

    return axios.post(`/api/login`, formData).then(response => response.data)
}

export const createAccount=(user, password)=>{
    console.log("Creating account");
    const formData = new FormData();
    formData.append('password', password);
    formData.append('user', JSON.stringify(user));

    return axios.post(`/api/createaccount`, formData).then(response => response.data)
}