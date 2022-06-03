set_languages("c++20")

add_requireconfs("*", {configs = {shared = true}})
add_requires("opencv 4.2.0")

-- set_targetdir("./")

for _, path2cxx in ipairs(os.files("./*.cxx")) do
    target(path.basename(path2cxx))
        set_kind("binary")
        add_files(path2cxx)
        add_packages("opencv")
end