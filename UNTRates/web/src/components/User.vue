<!-- This is a test-->
<script setup>
import {ref} from 'vue';
import { useRouter } from 'vue-router';
import {createAccount} from '@/api/users'

    const user = ref({
        username:"",
        first:"",
        last:"",
        email:"",
        phone:""
    })

    const emits = defineEmits(['cancel', 'created'])
    const router = useRouter();
    const password = ref();
    const password2 = ref();
    const createUser = ()=>{
        if(password.value == password2.value ){
            createAccount(user.value, password.value).then((response)=>{
                if(response.status){
                    alert("" + response.status);
                }
                else{
                    alert("Account created successfully");
                    emits('created');
                }
                console.log("Account creation", response)
            })
        }else{
            alert('Passwords do not match');
        }
    }
</script>

<template>
    <div class="d-flex flex-column flex-fill gap-2 p-3" >
        <h6>User Creation / Update</h6>
        <BFormInput v-model="user.username" placeholder="Username"></BFormInput>
        <BFormInput v-model="user.email" placeholder="User Email"></BFormInput>
        <BFormInput v-model="user.first" placeholder="First Name"></BFormInput>
        <BFormInput v-model="user.last" placeholder="Lastname"></BFormInput>
        <BFormInput v-model="user.phone" placeholder="Phone number"></BFormInput>
        <BFormInput v-model="password" placeholder="Password" type="password"></BFormInput>
        <BFormInput v-model="password2"placeholder="Re-enter Password" type="password"></BFormInput>

         <div class="d-flex gap-2">
            <div class="flex-fill"></div>
            <div class="btn btn-secondary" @click="emits('cancel')">Cancel</div>
            <div class="btn btn-primary" @click="createUser">Save</div>
        </div>
    </div>
</template>

<style lang="scss" scoped>

</style>