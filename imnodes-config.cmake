foreach(component ${noms_FIND_COMPONENTS})
    include(${CMAKE_CURRENT_LIST_DIR}/${component}-config.cmake)
endforeach()