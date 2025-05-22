{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          compression = "lz4";
          mountpoint = "none";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };
        options = {
          acltype = "posixacl";
          ashift = "12";
          atime = "off";
          compression = "lz4";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          #keylocation = "file:///tmp/secret.key";
          keylocation = "prompt";
          recordsize = "64k";
          xattr = "sa";
        };
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";
        datasets = {

          "root" = {
            type = "zfs_fs";
            options = {
              "com.sun:auto-snapshot" = "false";
            };
            mountpoint = "/";~
          };

          "root/nix" = {
            type = "zfs_fs";
            options = {
              "com.sun:auto-snapshot" = "false";
            };
            mountpoint = "/nix";
          };

          "root/home" = {
            type = "zfs_fs";
            options = {
              "com.sun:auto-snapshot" = "true";
            };
            mountpoint = "/home";
          };

          "root/persist" = {
            type = "zfs_fs";
            options = {
              "com.sun:auto-snapshot" = "true";
            };
            mountpoint = "/persist";
          };

        };
      };
    };
  };
}
