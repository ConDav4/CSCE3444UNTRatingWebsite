import axios from "axios";

export const addCourse=(course)=>{
    console.log("Adding course");
    return axios.post(`/api/courses/add`, course).then(response => response.data)
}

export const searchCourse=(searchStr)=>{
    console.log("Adding course");
    return axios.get(`/api/courses/profile/${searchStr}`).then(response => response.data)
}

export const getCourses=()=>{
    return axios.get(`/api/courses`).then(response => response.data)
}

export const updateCourseRating = (courseName, username, ratings) =>{
    const rating = {user:username,ratings:ratings}
    return axios.post(`/api/courses/profile/${courseName}/review`, rating).then(response=>response.data);
}