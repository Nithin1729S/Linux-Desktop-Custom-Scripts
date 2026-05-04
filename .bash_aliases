alias glp='git log --pretty=format:"%C(yellow)%h%Creset - %C(green)%an%Creset, %ar : %s"'
alias upt='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias contest='python3 /home/nithin/Codes/Projects/CP_Env_Creator/main.py'
alias runalltests="rm -rf build && mkdir build && cd build && cmake .. && make -j$(nproc) && ./run_tests"
