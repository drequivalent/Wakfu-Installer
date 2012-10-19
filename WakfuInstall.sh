sudo -K
if gksu --preserve-env --message "This will install Wakfu in your home directory and necessary libraries in your system. The only thing we need is Root access. Please provide your SUDO password." "echo 'Got root!'" ; then
{
    (
    echo "0"
    if ! dpkg -s deb-multimedia-keyring ; then
    {
        echo "# Getting the APT GPG key for Deb-Multimedia and installing it"
        wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2012.05.05_all.deb
        sudo dpkg -i ./deb-multimedia-keyring_2012.05.05_all.deb
        rm ./deb-multimedia-keyring_2012.05.05_all.deb
    }
    else
    {
        echo "# Keyring is present"
    }
    fi
    echo "10"
    if ! grep --quiet "deb http://www.debian-multimedia.org sid main non-free" /etc/apt/sources.list ; then
    {
        echo "# Adding Deb-Multimedia repository to sources.list"
        cp /etc/apt/sources.list ./sources.list
        sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
        echo "deb http://www.debian-multimedia.org sid main non-free" >> ./sources.list
        sudo mv ./sources.list /etc/apt/sources.list
    }
    else
    {
        echo "# Deb-Multimedia repository is present"
    }
    fi
    echo "20"
    if ! dpkg -s libtxc-dxtn0 libjpeg62 openjdk-7-jre ; then
    {
        echo "# Installing libraries and Java runtime environment"
        sudo apt-get update
        sudo apt-get --yes install libtxc-dxtn0 libjpeg62 openjdk-7-jre
    }
    else
    {
        echo "# All libraries are present"
    }
    fi
    echo "50"
    echo "# Downloading the official installer"
    wget http://dl.ak.ankama.com/games/wakfu/client/linux/Wakfu_unix.sh
    echo "60"
    echo "# Making installer executable and running it"
    chmod +x ./Wakfu_unix.sh
    echo "70"
    sh ./Wakfu_unix.sh
    echo "80"
    echo "# Making Wakfu executable"
    chmod +x ~/ankama/Wakfu/UpLauncher
    chmod +x ~/ankama/Wakfu/Wakfu
    echo "90"
    echo "# Removing installer"
    rm ./Wakfu_unix.sh
    echo "# Making an explicit launch script"
    echo "~/ankama/Wakfu/UpLauncher" > ~/Wakfu-launch.sh
    chmod +x ~/Wakfu-launch.sh
    echo "# Wakfu installation successful. Launch Wakfu-launch.sh in your home directory to start the game."
    echo "100" ) | zenity --progress --title="Installing Wakfu" --text="Initalizing" --percentage=0 --no-cancel --width 670
}
else
{
zenity --error --text="The installation won't continue without SUDO password"
}
fi
