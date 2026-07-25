<!-- This is a test-->
<script setup>
    import {ref, onMounted, computed} from 'vue';
    import { addProfessor, getProfessors, searchProfessor, updateProfessorRating } from '@/api/professors';
    import store from '@/store';

    const fieldsDflt = [
    {
        key: 'name',
        sortable: true,
    },
    {
        key: 'email',
        sortable: true,
    },
    {
        key: 'department',
        sortable: true,
    },
    {
        key: 'ratings',
        sortable: true,
        class:"min"
    }
]

    const professors = ref([]);
    const professorSearchResults = ref();
    const professor = ref({ ratings:{} });
    const selectedProfessor = ref();
    const showProfessorAdd = ref(false);
    const filter = ref();
    const searchStr = ref();
    const ratings = ref();

    const user = computed(() => store.state.user)
    const fields = computed(()=>{
        if(user?.guest){
            return fieldsDflt;
        }
        return [...fieldsDflt,
            {
                key: 'actions',
                sortable: false,
                class:"min"
            }]
    })

    const onProfessorAdd = ()=>{
        const professorAdd = JSON.parse(JSON.stringify(professor.value));
        professorAdd.ratings[user.value?.username]={rating:professorAdd.rating,comment:professorAdd.comment};
        delete professorAdd.rating;
        delete professorAdd.comment;

        addProfessor(professorAdd).then((response)=>{
            alert('Professor has been added successfully');
            refresh();
        })
    }

    const startProfessorUpdate = (professorIn)=>{
        const professorEdit = professorIn || JSON.parse(JSON.stringify({ ratings:{} }));
        professor.value = professorEdit;
        showProfessorAdd.value = true;
    }

    const selectProfessor = (selectedProfessorIn)=>{
        selectedProfessor.value = selectedProfessorIn;
        ratings.value = selectedProfessor.value.ratings[user.value.username] || {rating:0,comment:""};
    }

    const onProfessorSearch = ()=>{
        searchProfessor(searchStr.value).then((response)=>{
            professorSearchResults.value = Object.values(response)
                .map((professor)=>{
                    professor.rating=avgRatings(professor?.ratings);
                    return professor
                });
        })
    }

    const updateRating = ()=>{
        updateProfessorRating(selectedProfessor?.value?.name,user.value?.username,ratings?.value).then((response)=>{
            alert("Rating has bee updated successfully")
        })
    }

    const refresh = ()=>{
        getProfessors().then((response)=>{
            professors.value = Object.values(response)
                .map((professor)=>{
                    professor.rating=avgRatings(professor?.ratings);
                    return professor
                });
        })
    }

    const avgRatings = (ratings)=>{
        if(ratings){
            const values = Object.values(ratings);
            if( values ){
                return values.reduce((sum, ratingPair) => sum + ratingPair.rating, 0) / values.length;
            }
        }
        return 0;
    }

    onMounted(()=>{
        refresh();
    })
</script>

<template>
    <div class="p-3">
        <div v-if="!selectedProfessor">
            <div class="d-flex flex-column my-2 mt-4">
                <h5 class="border-bottom pb-2 mb-3">Professor Search</h5>
                <div class="d-flex flex-column flex-fill gap-3 rounded">
                    <div class="d-flex gap-3">
                        <BFormInput class="flex-fill" v-model="searchStr" placeholder="Enter professors name" @keyup.enter="onProfessorSearch"/>
                        <div class="btn btn-sm btn-primary" @click="onProfessorSearch">Search</div>
                    </div>
                    <div v-if="professorSearchResults?.length==0" class="d-flex align-items-center p-2 rounded darker">
                        <div class="flex-fill">No professors found with that name. {{(!user?.guest)?' Would you like to add one?':''}} </div>
                        <div class="btn btn-primary" v-if="!user?.guest" @click="startProfessorUpdate()">Add Professor</div>
                    </div>
                    <div v-else-if="professorSearchResults?.length" class="darker">
                        <BTable 
                            striped
                            hover
                            :filter="filter"
                            :items="professorSearchResults"
                            :fields="fields"
                            show-empty
                            responsive
                        >
                            <template v-slot:cell(ratings)="data">
                                <BFormRating v-model="data.item.rating" no-border size="sm" show-value readonly color="rgb(64, 192, 128)" style="width:100%;min-width:100pt"/>
                            </template>
                            <template v-slot:cell(actions)="data">
                                <div class="btn btn-primary" v-if="!user?.guest" @click="selectProfessor(data.item)">Review</div>
                            </template>
                            <template #empty>
                                <div class="text-center text-muted my-2">
                                    Custom empty message here
                                </div>
                            </template>
                        </BTable>
                    </div>
                </div>
            </div>
            <div class="d-flex align-items-center my-2 mt-5 border-bottom pb-2">
                <h5>Professor Listing</h5>
                <div class="flex-fill">&nbsp;</div>
                <i class="mdi mdi-filter me-2"></i>
                <BFormInput class="" style="width:200pt;" v-model="filter" placeholder="Start typing to filter professors"/>
            </div>
            <div class="d-flex flex-column flex-fill gap-3 rounded darker">
                <BTable
                    class="mb-0"
                    striped
                    hover
                    :filter="filter"
                    :items="professors"
                    :fields="fields"
                    show-empty
                    responsive
                >
                    <template v-slot:cell(ratings)="data">
                        <BFormRating v-model="data.item.rating" no-border size="sm" show-value readonly color="rgb(64, 192, 128)" style="width:100%;min-width:100pt"/>
                    </template>
                    <template v-slot:cell(actions)="data">
                        <div class="btn btn-primary"  v-if="!user?.guest" @click="selectProfessor(data.item)">Review</div>
                    </template>
                    <template #empty>
                        <div class="text-center text-muted">
                            No professors found at this time
                        </div>
                    </template>
                </BTable>
                </div>
        </div>
        <div v-else class="d-flex flex-column h-100">
            <h5 class="border-bottom pb-2 d-flex align-items-center">
                <i class="mdi mdi-human-male-board-poll me-2"></i>
                <span class="fw-bold">Professor Ratings: </span>
                <span class="flex-fill mx-3 text-uppercase">{{ selectedProfessor.name }} </span>
                <span><i class="mdi mdi-close" role="button" @click="selectedProfessor=null"></i></span>
            </h5>
            <div class="my-2 darker rounded d-flex flex-column gap-2 p-3">
                <div class="mb-2">{{(ratings.rating)?'Your Current':'Add a'}} Rating</div>
                <BFormRating v-model="ratings.rating" class="w-100" no-border size="sm" show-value color="rgb(64, 192, 128)"/>
                <BFormTextarea v-model="ratings.comment"/>
                <div class="text-end"><div class="btn btn-primary" @click="updateRating">{{(ratings.rating)?'Update':'Add'}}</div></div>
            </div>
            <div class="mt-3 mb-2">Current Ratings:</div>
            <div class="d-flex" style="flex:1 1 0;min-height:0;">
                <div class="flex-fill">
                    <div v-for="(rating, user) in selectedProfessor?.ratings" class="darker p-3 rounded mb-4">
                        <div  class="d-flex align-items-center">
                            <div class="user-icon"><i class="mdi mdi-account"></i></div>
                            <div class="flex-fill mx-3 fw-bold text-capitalize">{{ user }}</div>
                            <div>
                                <BFormRating v-model="rating.rating" class="d-flex align-items-center" no-border size="sm" show-value readonly color="rgb(64, 192, 128)" style="width:100%;min-width:100pt"/>
                            </div>
                        </div>
                        <div class="border rounded p-2 mt-2" style="background-color:var(--bs-body-bg)">
                            <div><small>Comment:</small></div>
                            <div><i class="mdi mdi-format-quote-open"></i>{{ rating.comment }}<i class="mdi mdi-format-quote-close"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <BModal v-model="showProfessorAdd" title="Professor Rating" no-footer>
            <div class="d-flex align-items-center my-2">
                <i class="text-muted p-2">To add an new professor review, simply fill in the following information.  
                    You may add comments and ratings at this time, or wait to come back later.
                </i>
            </div>
            <div v-if="showProfessorAdd" class="d-flex flex-column flex-fill gap-3 rounded darker p-3">
                <BFormInput v-model="professor.name" placeholder="Please enter professor's name"/>
                <BFormInput v-model="professor.degree" placeholder="Please enter professor's degree"/>
                <BFormInput v-model="professor.department" placeholder="Please enter professor's department"/>
                <BFormRating v-model="professor.rating" class="w-100" no-border size="sm" color="rgb(64, 192, 128)" show-value/>
                <BFormTextarea v-model="professor.comment"/>

                <div class="d-flex gap-3 jsutify-content-end">
                    <div class="flex-fill"></div>
                    <div class="btn btn-primary" @click="onProfessorAdd">Add</div>
                </div>
            </div>
        </BModal>
    </div>
</template>

<style lang="scss" scoped>
    .user-icon{
        font-size:1.5em;
        line-height:1.2em;
        display:block;
        height:1.5em;
        width:1.5em;
        padding:0px;
        background-color:rgba(0,0,0,0.2);
        border-radius:50%;
        border:solid 1px #333;
        text-align:center;
    }
</style>