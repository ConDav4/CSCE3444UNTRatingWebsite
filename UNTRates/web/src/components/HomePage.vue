<!-- This is a test-->
<script setup>
    import Header from './inc/Header.vue';
</script>

<template>
    <div class="d-flex flex-column flex-fill">
        <div  style="flex: 1 1 0; min-height:0;overflow-y:auto;">
        <div class="border primary-container d-flex align-items-center p-3" style="height:calc( 100vh - 62px );"> 
            
               
            <div class="text-box d-flex align-items-center justify-content-center">
                <pre>
                    <h1 class="fw-bold display-1">Welcome to 
UNTRates!</h1>
                </pre>
            </div>
           

        </div>
        
        <div class="info d-flex flex-column gap-3 p-3">
            
                    <div class="d-flex flex-column flex-md-row">
                        <div class="fw-bold text-nowrap fs-4">
                            What is UNTRates?
                        </div>
                        <div>
                            
                                UNTRates is a student made webpage which contains the ratings of UNT professors and courses, added by UNT students.
                            
                        </div>
                    </div>

                    <div class="d-flex flex-column flex-md-row">
                        <div class="fw-bold fs-4">
                            Why did we make UNTRates? 
                        </div>
                        <div>
                            
                                UNTRates was created because of the lack of UNT specific rating tools available to UNT students, and the stress that can come when choosing classes
                                on a large campus with many different teachers. While broader proffessor rating sites are
                                available, finding UNT professors can be hard, and there's no formal UNT course rating. This websites goal was to provide a places
                                specifically for UNT students to be able to not only find that information, but also add to it themselves, and help future students choose
                                a professor and course that will best fit them based off of the lived experiences of students who have actually taken these professors
                                and courses. 
                        </div>
                    </div>

                    <div class="d-flex flex-column flex-md-row">
                        <div class="fw-bold fs-4">
                            How to use UNTRates:
                        </div>
                        <div>
                            
                                UNTRates is usuable without an account, allowing for searching of both courses and professors in the guest state. Once creating an 
                                account however the possibilities that this website can offer to you open up to include adding and rating both professors and courses 
                                as well. Usuability features include the option to switch to dark mode and the ability to access the website on mobile with complemtary
                                formatting. Navigating to the professor and courses pages will allow for searching of the two categories respectfully, where new entrys can be 
                                made through the search. 
                           
                        </div>
                    </div>
                

        </div>
        </div>


    </div>


</template>

<style lang="scss" scoped>
    .primary-container{
        background:url('@/assets/images/untcooler.jpg') center/cover;
    }

    .h1{
        font-family:'Times New Roman', Times, serif;
        font-size: large;
    }

    .text-box {
        width: 50vw;
        height: 75vh;
        text-align: center;
        color: #1d1115;
        letter-spacing: 1px;
        font-style: italic;
        h1{
            font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }

        border: 1px black;
        background-color: rgba(255,255,255,0.7);
        padding: 10px 15px;
        //margin: 10px 15px;
    }

    .info{
        & > div > div:first-child{
            min-width: 250px;
            max-width:250px;
        }
    }

    @media screen and (max-width: 768px) {
        .text-box{
            width: 100%;
        }
        .info{
            & > div > div:first-child{
                min-width:100%;
                max-width:100%;
            }
        }
    }
</style>