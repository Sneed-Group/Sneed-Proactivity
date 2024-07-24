rule Win32_Ransomware_MRAC : tc_detection malicious
{
    meta:

        author              = "ReversingLabs"

        source              = "ReversingLabs"
        status              = "RELEASED"
        sharing             = "TLP:WHITE"
        category            = "MALWARE"
        malware             = "MRAC"
        description         = "Yara rule that detects MRAC ransomware."

        tc_detection_type   = "Ransomware"
        tc_detection_name   = "MRAC"
        tc_detection_factor = 5

    strings:

        $encrypt_files = {
            B8 ?? ?? ?? ?? 66 8B 11 66 3B 10 75 ?? 66 85 D2 74 ?? 66 8B 51 ?? 66 3B 50 ?? 75 ??
            83 C1 ?? 83 C0 ?? 66 85 D2 75 ?? 33 C0 EB ?? 1B C0 83 C8 ?? 8B 75 ?? 85 C0 75 ?? B1
            ?? EB ?? 32 C9 8B 45 ?? 88 4D ?? 83 F8 ?? 72 ?? 8D 0C 45 ?? ?? ?? ?? 8B C6 81 F9 ??
            ?? ?? ?? 72 ?? 8B 76 ?? 83 C1 ?? 2B C6 83 C0 ?? 83 F8 ?? 77 ?? 51 56 E8 ?? ?? ?? ??
            8A 4D ?? 83 C4 ?? 8A C1 8B 4D ?? 64 89 0D ?? ?? ?? ?? 59 5F 5E 8B 4D ?? 33 CD E8 ??
            ?? ?? ?? 8B E5 5D C2 ?? ?? E8 ?? ?? ?? ?? E8
        }

        $import_key = {
            8D 45 ?? 50 6A ?? 6A ?? 6A ?? FF 75 ?? 56 6A ?? 68 ?? ?? ?? ?? FF 15 ?? ?? ?? ?? 85
            C0 0F 84 ?? ?? ?? ?? FF 75 ?? 6A ?? FF 15 ?? ?? ?? ?? FF 75 ?? E8 ?? ?? ?? ?? 83 C4
            ?? 89 45 ?? 8D 4D ?? 51 50 6A ?? 6A ?? FF 75 ?? 56 6A ?? 68 ?? ?? ?? ?? FF 15 ?? ??
            ?? ?? 85 C0 0F 84 ?? ?? ?? ?? 8D 45 ?? 50 6A ?? 6A ?? FF 75 ?? FF 75 ?? FF 75 ?? FF
            15 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ?? 8D 45 ?? 50 6A ?? 68 ?? ?? ?? ?? FF 75 ?? FF
            15 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ?? 8B 35 ?? ?? ?? ?? 8D 45 ?? 6A ?? 50 6A ?? FF
            75 ?? FF D6 85 C0 0F 84 ?? ?? ?? ?? 6A ?? 8D 45 ?? 50 6A ?? FF 75 ?? FF D6 85 C0 0F
            84 ?? ?? ?? ?? 8D 45 ?? 50 6A ?? FF 75 ?? FF 15 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ??
            6A ?? 8D 45 ?? 50 6A ?? FF 75 ?? FF D6 85 C0 0F 84 ?? ?? ?? ?? 6A ?? FF 75 ?? FF 15
            ?? ?? ?? ?? 8B C8 F6 C1 ?? 75 ?? B8 ?? ?? ?? ?? EB ?? 8B C1 C1 E8 ?? 40 C1 E0 ?? 2B
            C1 68 ?? ?? ?? ?? 89 45 ?? E8 ?? ?? ?? ?? 8B F8 83 C4 ?? 85 FF 0F 84 ?? ?? ?? ?? 6A
            ?? 8D 45 ?? 50 68 ?? ?? ?? ?? 57 FF 75 ?? FF 15 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ??
            8B 45 ?? 3D ?? ?? ?? ?? 0F 92 C3 85 C0 74 ?? 68 ?? ?? ?? ?? 8D 45 ?? 50 57 6A ?? 0F
            B6 C3 50 6A ?? FF 75 ?? FF 15 ?? ?? ?? ?? 8B 75 ?? 85 C0 0F 84 ?? ?? ?? ?? 6A ?? 8D
            45 ?? 50 FF 75 ?? 57 56 FF 15 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ?? EB ?? 8B 75 ?? 84
            DB 74
        }

        $find_files = {
            55 8B EC 6A ?? 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 83 EC ?? A1 ?? ?? ?? ?? 33 C5 89
            45 ?? 53 56 57 50 8D 45 ?? 64 A3 ?? ?? ?? ?? 89 4D ?? 8B 45 ?? 50 E8 ?? ?? ?? ?? 83
            C4 ?? 85 C0 74 ?? 32 C0 E9 ?? ?? ?? ?? 6A ?? E8 ?? ?? ?? ?? 83 C4 ?? 8B F0 68 ?? ??
            ?? ?? 68 ?? ?? ?? ?? FF 15 ?? ?? ?? ?? 8B 3D ?? ?? ?? ?? 68 ?? ?? ?? ?? 50 89 06 FF
            D7 85 C0 0F 84 ?? ?? ?? ?? 8B 1D ?? ?? ?? ?? 90 68 ?? ?? ?? ?? 68 ?? ?? ?? ?? FF D3
            F6 05 ?? ?? ?? ?? ?? 68 ?? ?? ?? ?? 0F 84 ?? ?? ?? ?? E8 ?? ?? ?? ?? 84 C0 75 ?? 8B
            4D ?? 6A ?? 68 ?? ?? ?? ?? E8
        }

    condition:
        uint16(0) == 0x5A4D and
        (
            $find_files
        ) and
        (
            $import_key
        ) and
        (
            $encrypt_files
        )
}