<!-- This is a test-->
<script setup>
import {ref, computed} from 'vue';
import { useRouter } from 'vue-router';
import {createAccount} from '@/api/users';
import store from '@/store';

    const user = computed(() => store.state.user)

    const emits = defineEmits(['created', 'canceled'])
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
        <h5>User Profile</h5>
        <div v-if="!user || user?.username=='Guest'">
            Username: <b>Guest</b>
        </div>
        <div v-else>
            <BFormInput v-model="user.username" placeholder="Username"></BFormInput>
            <BFormInput v-model="user.email" placeholder="User Email"></BFormInput>
            <BFormInput v-model="user.first" placeholder="First Name"></BFormInput>
            <BFormInput v-model="user.last" placeholder="Lastname"></BFormInput>
            <BFormInput v-model="user.phone" placeholder="Phone number"></BFormInput>
            <BFormInput v-model="password" placeholder="Password" type="password"></BFormInput>
            <BFormInput v-model="password2"placeholder="Re-enter Password" type="password"></BFormInput>

            <div class="d-flex gap-2">
                <div class="flex-fill"></div>
                <div class="btn btn-secondary" @click="cancel">Cancel</div>
                <div class="btn btn-primary" @click="createUser">Save</div>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>

</style>