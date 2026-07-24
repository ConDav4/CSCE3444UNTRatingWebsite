<!-- This is a test-->
<script setup>
    import {ref, onMounted, computed} from 'vue';
    import { addCourse, getCourses, searchCourse, updateCourseRating } from '@/api/courses';
    import store from '@/store';

    const fieldsDflt = [
    {
        key: 'name',
        sortable: true,
    },
    {
        key: 'degree',
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

    const courses = ref([]);
    const courseSearchResults = ref();
    const course = ref({ ratings:{} });
    const selectedCourse = ref();
    const showCourseAdd = ref(false);
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

    const onCourseAdd = ()=>{
        const courseAdd = JSON.parse(JSON.stringify(course.value));
        courseAdd.ratings[user.value?.username]={rating:courseAdd.rating,comment:courseAdd.comment};
        delete courseAdd.rating;
        delete courseAdd.comment;

        addCourse(courseAdd).then((response)=>{
            alert('Course has been added successfully');
            refresh();
        })
    }

    const startCourseUpdate = (courseIn)=>{
        const courseEdit = courseIn || JSON.parse(JSON.stringify({ ratings:{} }));
        course.value = courseEdit;
        showCourseAdd.value = true;
    }

    const selectCourse = (selectedCourseIn)=>{
        selectedCourse.value = selectedCourseIn;
        ratings.value = selectedCourse.value.ratings[user.value.username] || {rating:0,comment:""};
    }

    const onCourseSearch = ()=>{
        searchCourse(searchStr.value).then((response)=>{
            courseSearchResults.value = Object.values(response)
                .map((course)=>{
                    course.rating=avgRatings(course?.ratings);
                    return course
                });
        })
    }

    const updateRating = ()=>{
        updateCourseRating(selectedCourse?.value?.name,user.value?.username,ratings?.value).then((response)=>{
            alert("Rating has bee updated successfully")
        })
    }

    const refresh = ()=>{
        getCourses().then((response)=>{
            courses.value = Object.values(response)
                .map((course)=>{
                    course.rating=avgRatings(course?.ratings);
                    return course
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
        <div v-if="!selectedCourse">
            <div class="d-flex flex-column my-2 mt-4">
                <h5 class="border-bottom pb-2 mb-3">Course Search</h5>
                <div class="d-flex flex-column flex-fill gap-3 rounded">
                    <div class="d-flex gap-3">
                        <BFormInput class="flex-fill" v-model="searchStr" placeholder="Enter courses name" @keyup.enter="onCourseSearch"/>
                        <div class="btn btn-sm btn-primary" @click="onCourseSearch">Search</div>
                    </div>
                    <div v-if="courseSearchResults?.length==0" class="d-flex align-items-center p-2 rounded darker">
                        <div class="flex-fill">No courses found with that name. {{(!user?.guest)?' Would you like to add one?':''}} </div>
                        <div class="btn btn-primary" v-if="!user?.guest" @click="startCourseUpdate()">Add Course</div>
                    </div>
                    <div v-else-if="courseSearchResults?.length" class="darker">
                        <BTable 
                            striped
                            hover
                            :filter="filter"
                            :items="courseSearchResults"
                            :fields="fields"
                            show-empty
                        >
                            <template v-slot:cell(ratings)="data">
                                <BFormRating v-model="data.item.rating" no-border size="sm" show-value readonly style="width:100%;min-width:100pt"/>
                            </template>
                            <template v-slot:cell(actions)="data">
                                <div class="btn btn-primary" v-if="!user?.guest" @click="selectCourse(data.item)">Review</div>
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
                <h5>Course Listing</h5>
                <div class="flex-fill">&nbsp;</div>
                <i class="mdi mdi-filter me-2"></i>
                <BFormInput class="" style="width:200pt;" v-model="filter" placeholder="Start typing to filter courses"/>
            </div>
            <div class="d-flex flex-column flex-fill gap-3 rounded darker">
                <BTable
                    class="mb-0"
                    striped
                    hover
                    :filter="filter"
                    :items="courses"
                    :fields="fields"
                    show-empty
                >
                    <template v-slot:cell(ratings)="data">
                        <BFormRating v-model="data.item.rating" no-border size="sm" show-value readonly style="width:100%;min-width:100pt"/>
                    </template>
                    <template v-slot:cell(actions)="data">
                        <div class="btn btn-primary"  v-if="!user?.guest" @click="selectCourse(data.item)">Review</div>
                    </template>
                    <template #empty>
                        <div class="text-center text-muted">
                            No courses found at this time
                        </div>
                    </template>
                </BTable>
                </div>
        </div>
        <div v-else class="d-flex flex-column h-100">
            <h5 class="border-bottom pb-2 d-flex align-items-center">
                <i class="mdi mdi-human-male-board-poll me-2"></i>
                <span class="fw-bold">Course Ratings: </span>
                <span class="flex-fill mx-3 text-uppercase">{{ selectedCourse.name }} </span>
                <span><i class="mdi mdi-close" role="button" @click="selectedCourse=null"></i></span>
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
                    <div v-for="(rating, user) in selectedCourse?.ratings" class="darker p-3 rounded mb-4">
                        <div  class="d-flex align-items-center">
                            <div class="user-icon"><i class="mdi mdi-account"></i></div>
                            <div class="flex-fill mx-3 fw-bold text-capitalize">{{ user }}</div>
                            <div>
                                <BFormRating v-model="rating.rating" class="d-flex align-items-center" no-border size="sm" show-value readonly style="width:100%;min-width:100pt"/>
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
        <BModal v-model="showCourseAdd" title="Course Rating" no-footer>
            <div class="d-flex align-items-center my-2">
                <i class="text-muted p-2">To add an new course review, simply fill in the following information.  
                    You may add comments and ratings at this time, or wait to come back later.
                </i>
            </div>
            <div v-if="showCourseAdd" class="d-flex flex-column flex-fill gap-3 rounded darker p-3">
                <BFormInput v-model="course.name" placeholder="Please enter course's name"/>
                <BFormInput v-model="course.degree" placeholder="Please enter course's degree"/>
                <BFormInput v-model="course.department" placeholder="Please enter course's department"/>
                <BFormRating v-model="course.rating" class="w-100" no-border size="sm" show-value/>
                <BFormTextarea v-model="course.comment"/>

                <div class="d-flex gap-3 jsutify-content-end">
                    <div class="flex-fill"></div>
                    <div class="btn btn-primary" @click="onCourseAdd">Add</div>
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