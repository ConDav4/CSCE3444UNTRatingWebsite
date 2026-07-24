<script setup>
    import {ref, onMounted, computed} from 'vue';
    import User from '../User.vue';
    import { userLogin } from '@/api/users';
    import { useRouter } from 'vue-router';
    import store from '@/store';
    import { useColorMode } from 'bootstrap-vue-next'
    import  untLogo  from '../../assets/images/UNTRates_logo.png'

    // target null applies the theme attribute globally to the <html> tag
    const mode = useColorMode({
        selector: 'html', // Targets <html data-bs-theme="...">
        attribute: 'data-bs-theme',
    })

    // Toggle function between light and dark modes
    const toggleTheme = () => {
        mode.value = mode.value === 'dark' ? 'light' : 'dark'
    }

    const showUserLoginModal = ref(false);
    const toggleUserCreate = ref(false);

    const user = computed(() => store.state.user)
    const username = ref();
    const password = ref();

    const router = useRouter();
    const createAccount = ()=>{
        showUserLoginModal.value = true;
        toggleUserCreate.value= true;
    }

    const login = ()=>{
        userLogin(username.value, password.value).then((response)=>{
            const userJson = response;
            if( userJson?.username ){
                sessionStorage.setItem('user',JSON.stringify(userJson));
                store.commit('SET_USER', userJson);
                showUserLoginModal.value = false;
            }
            else{
                alert("Unable to retrieve user details... Please try again");
            }
        }).catch((e)=>{
            alert("Invalid Login Credentials... Please try again");
        })
    }

    const signout = ()=>{
        user.value = null;
        sessionStorage.removeItem('user');
        store.commit('CLEAR_USER')
    }

    onMounted(()=>{
        const userData = sessionStorage.getItem('user');
        if(userData){
            const userJson = JSON.parse(userData);
            store.commit('SET_USER', userJson)
        }
    })
</script>

<template>
    <BNavbar
    toggleable="lg"
    class="header text-dark"
    >
    <BNavbarBrand href="#navbar-overview"><BImg :src="untLogo" fluid alt="Local logo" style="height: 35px;"/></BNavbarBrand>
    <BNavbarToggle target="nav-collapse" />
    <BCollapse
        id="nav-collapse"
        is-nav
    >
        <BNavbarNav>
        <BNavItem href="/">
            Home
        </BNavItem>
        <BNavItem @click="router.push('/professors')">
            Professor
        </BNavItem>
        <BNavItem @click="router.push('/courses')">
            Courses
        </BNavItem>
        </BNavbarNav>
        <!-- Right aligned nav items -->
        <BNavbarNav class="ms-auto mb-2 mb-lg-0">
        <BNavItem @click="toggleTheme">
            <i class="mdi mdi-theme-light-dark"></i>
        </BNavItem>
        <BNavItemDropdown text="Lang" right>
            <BDropdownItem>EN</BDropdownItem>
            <BDropdownItem>ES</BDropdownItem>
            <BDropdownItem>RU</BDropdownItem>
            <BDropdownItem>FA</BDropdownItem>
        </BNavItemDropdown>
        <BNavItemDropdown right toggle-class="rounded bg-white mx-3">
            <!-- Using 'button-content' slot -->
            <template #button-content>
            <span class="rounded bg-white py-2 px-3">
                <em><i class="mdi mdi-account-circle-outline me-2"></i>
                <span class="fw-bold text-capitalize">{{user?.username || 'Not Logged In'}}</span></em>
            </span>
            </template>
            <template v-if="!user || user?.username=='Guest'">
                <BDropdownItem @click="()=>{showUserLoginModal=true;toggleUserCreate=false;}">Login</BDropdownItem>
                <BDropdownItem @click="createAccount">Create User</BDropdownItem>
            </template>
            <template v-else>
                <BDropdownItem @click="router.push('/user');">Profile</BDropdownItem>
                <BDropdownItem @click="signout">Sign Out</BDropdownItem>
            </template>
        </BNavItemDropdown>
        </BNavbarNav>
        <BNavForm class="d-flex">

        </BNavForm>
    </BCollapse>
    <BModal v-model="showUserLoginModal" title="User Account" size="lg" no-footer>
        <User v-if="toggleUserCreate" @created="toggleUserCreate=false" @cancel="showUserLoginModal=false"></User>
        <div v-else class="d-flex flex-column gap-2">
            <BFormInput v-model="username" placeholder="Username"/>
            <BFormInput v-model="password" placeholder="Enter Password" type="password"/>
            <div class="d-flex gap-2">
                <div class="flex-fill"></div>
                <div class="btn btn-secondary" @click="createAccount">Create Account</div>
                <div class="btn btn-primary" @click="login">Login</div>
            </div>
        </div>
    </BModal>
    </BNavbar>
</template>

<style lang="scss" scoped>
    .header{
        background-color:#B9DCD2;
        color:#eee;
    }
</style>