#
# spec file for package util-linux
#
# Copyright (c) 2023 SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


Name:           util-linux
Version:        9999.99.99
Release:        0
Summary:        Dummy package to make a package manager think Linux util-linux is installed if you choose to use uutils util-linux instead
License:        MIT
URL:            https://github.com/Trijal08/uutils-converter/
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

Provides:       /usr/bin/blockdev
Provides:       /bin/blockdev
Provides:       /usr/bin/chcpu
Provides:       /bin/chcpu
Provides:       /usr/bin/ctrlaltdel
Provides:       /bin/ctrlaltdel
Provides:       /usr/bin/dmesg
Provides:       /bin/dmesg
Provides:       /usr/bin/fsfreeze
Provides:       /bin/fsfreeze
Provides:       /usr/bin/last
Provides:       /bin/last
Provides:       /usr/bin/lscpu
Provides:       /bin/lscpu
Provides:       /usr/bin/lsipc
Provides:       /bin/lsipc
Provides:       /usr/bin/lslocks
Provides:       /bin/lslocks
Provides:       /usr/bin/lsmem
Provides:       /bin/lsmem
Provides:       /usr/bin/mcookie
Provides:       /bin/mcookie
Provides:       /usr/bin/mesg
Provides:       /bin/mesg
Provides:       /usr/bin/mountpoint
Provides:       /bin/mountpoint
Provides:       /usr/bin/renice
Provides:       /bin/renice
Provides:       /usr/bin/rev
Provides:       /bin/rev
Provides:       /usr/bin/setsid
Provides:       /bin/setsid

     

%description
Dummy package to make a package manager think Linux util-linux is installed if you choose to use uutils util-linux instead

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/tmp
cp %{name} $RPM_BUILD_ROOT/tmp

%files
/tmp/%{name}

%changelog
* Mon Mar  17 2025 Trijal Saha <trijal.saha@proton.me> - 9999.99.99
- First version being packaged
