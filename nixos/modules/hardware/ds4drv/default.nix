{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  evdev,
  pyudev,
  bluez,
  setuptools,
}:

buildPythonPackage rec {
  pname = "ds4drv";
  version = "0.5.1";

  pyproject = true;
  build-system = [ setuptools ];

  # PyPi only carries py3 wheel
  src = fetchFromGitHub {
    owner = "chrippa";
    repo = "ds4drv";
    #rev = "v${version}";
    #sha256 = "0vinpla0apizzykcyfis79mrm1i6fhns83nkzw85svypdhkx2g8v";
    rev = "efe0e335164d6d605ec8927340fa4b479745003f"; # dualsense support pull request
    sha256 = "sha256-yQSJaDLsyVXtQEZWoWmKMigD7mqd2M0CQSUCafWnb+k=";
  };

  postPatch = ''
    substituteInPlace ds4drv/config.py \
      --replace-fail SafeConfigParser ConfigParser
    # needed to work
    sed -i 's#joystick.device.device.fn#joystick.device.device.fd#g' ds4drv/actions/input.py
  '';

  dependencies = [
    evdev
    pyudev
  ];

  buildInputs = [ bluez ];

  meta = {
    description = "Userspace driver for the DualShock 4 controller";
    mainProgram = "ds4drv";
    homepage = "https://github.com/chrippa/ds4drv";
    license = lib.licenses.mit;
  };
}
