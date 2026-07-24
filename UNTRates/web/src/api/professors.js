import axios from "axios";

export const addProfessor=(professor)=>{
    console.log("Adding professor");
    return axios.post(`/api/professors/add`, professor).then(response => response.data)
}

export const searchProfessor=(searchStr)=>{
    console.log("Adding professor");
    return axios.get(`/api/professors/profile/${searchStr}`).then(response => response.data)
}

export const getProfessors=()=>{
    return axios.get(`/api/professors`).then(response => response.data)
}

export const updateProfessorRating = (professor, username, ratings) =>{
    const rating = {user:username,ratings:ratings}
    return axios.post(`/api/professors/profile/${professor}/review`, rating).then(response=>response.data);
}