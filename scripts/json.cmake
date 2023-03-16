include(FetchContent)

set(JSON_MultipleHeaders OFF)

FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent.git
    GIT_TAG        master
    GIT_PROGRESS TRUE
)
message("json")
FetchContent_MakeAvailable(json)
