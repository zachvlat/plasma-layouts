cmake_minimum_required(VERSION 3.16)

project(plasma_layouts VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core Widgets)

qt_standard_project_setup(REQUIRES 6.9)

qt_add_executable(appplasma_layouts
    main.cpp
    layouthandler.cpp
)

qt_add_qml_module(appplasma_layouts
    URI plasma_layouts
    QML_FILES
        Main.qml
        LayoutCard.qml
    RESOURCES
        assets/icon.svg
        assets/Macos/plasma-org.kde.plasma.desktop-appletsrc
        assets/Cosmic/plasma-org.kde.plasma.desktop-appletsrc
        assets/Windows/plasma-org.kde.plasma.desktop-appletsrc
        assets/Ubuntu/plasma-org.kde.plasma.desktop-appletsrc

        assets/NeoCosmic/plasma-org.kde.plasma.desktop-appletsrc
        assets/WM/plasma-org.kde.plasma.desktop-appletsrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appplasma_layouts PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appplasma_layouts
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE_ICON_FILE "icon.svg"
)

target_link_libraries(appplasma_layouts
    PRIVATE Qt6::Quick Qt6::Core Qt6::Widgets
)

# Set application icon
if(WIN32)
    set_target_properties(appplasma_layouts PROPERTIES
        WIN32_EXECUTABLE TRUE
    )
endif()

include(GNUInstallDirs)
install(TARGETS appplasma_layouts
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install assets directory
install(DIRECTORY assets/
    DESTINATION ${CMAKE_INSTALL_BINDIR}/assets
    PATTERN "*.png" EXCLUDE
    PATTERN "icon.svg" EXCLUDE
)
