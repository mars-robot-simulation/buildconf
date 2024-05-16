# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# Uncomment to reenable building the RTT test suite
# This is disabled by default as it requires a lot of time and memory
#
# Autobuild::Package['rtt'].define "BUILD_TESTING", "ON"

# Package specific prefix:
# Autobuild::Package['rtt'].prefix='/opt/autoproj/2.0'
#
# See config.yml to set the prefix:/opt/autoproj/2.0 globally for all packages.

Autobuild::Package.each do |name, pkg|
    if pkg.kind_of?(Autobuild::CMake)
        # please leave this on "Release", this setting accounts for a 4.5GB bigger docker release image (install folder)
        # if you need debug info, add overrides per package below
        pkg.define "CMAKE_BUILD_TYPE", "Release"
    end
end

Autobuild::Package['planning/orogen/area_exploration'].define "CMAKE_BUILD_TYPE", "Debug"

# Autobuild::Package['slam/cloud_slam_connector'].define "CMAKE_BUILD_TYPE", "Debug"

Autoproj.manifest.each_autobuild_package do |pkg|
    if pkg.kind_of?(Autobuild::Orogen)
        pkg.orogen_options << '--extensions=textlog'
        pkg.depends_on 'tools/orogen_textlog'
    end
end


# enable this to build with qt5 (also enable the overrides from overrides.d/99-qt5.yml)
# run "autopronj envsh" and ". env.sh" afterwards
Autoproj.env_add "USE_QT5", "1"

# has to be set on ALL libs to actually work for the task
Autobuild::Package['planning/area_exploration'].define "ENABLE_DEBUG_DRAWINGS", "ON"
Autobuild::Package['planning/traversability_generator3d'].define "ENABLE_DEBUG_DRAWINGS", "ON"
Autobuild::Package['planning/ugv_nav4d'].define "ENABLE_DEBUG_DRAWINGS", "ON"
Autobuild::Package['planning/orogen/area_exploration'].define "ENABLE_DEBUG_DRAWINGS", "ON"
