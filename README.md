# RustDesk ID Update Script

This PowerShell script automates the process of updating the RustDesk ID and password and securely storing the information in Bitwarden.

## Features

- Update RustDesk ID with options for:
  - Using the system hostname
  - Generating a random 9-digit number
  - Entering a custom value
- Generate a new random password for RustDesk

## Prerequisites

- Windows operating system
- PowerShell 5.1 or later
- RustDesk installed on the system

## Installation

1. Clone this repository or download the script file:
   ```
   git clone https://github.com/d-divita/change-rustdesk-id.git
   ```
   or download `rustdesk-config-update.ps1` directly.

2. Ensure that PowerShell execution policy allows running scripts:
   ```powershell
   Get-ExecutionPolicy -List
   ```
4. If not, you may need to run:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
   ```
5. You can revert PowerShell execution policy to default value by running:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
   ```

## Usage

1. Open PowerShell as an administrator.

2. Navigate to the directory containing the script:
   ```powershell
   cd path\to\script\directory
   ```

3. Run the script:
   ```powershell
   .\rustdesk-config-update.ps1
   ```

4. Follow the on-screen prompts to:
   - Choose a new RustDesk ID
   - Confirm the updates

## Configuration

The script doesn't require any pre-configuration. All necessary inputs are prompted during execution.

## Security Considerations

- The script generates a random 16-character password for RustDesk.
- No sensitive information is stored or sent anywhere.

## Contributing

Contributions to improve the script are welcome. Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` file for more information.

## Acknowledgements
- [This Reddit Comment](https://old.reddit.com/r/rustdesk/comments/140zfl0/any_way_to_set_custom_id/jnftk2t/)
- [RustDesk](https://rustdesk.com/)
- [PowerShell](https://docs.microsoft.com/en-us/powershell/)

## Support

For support, please open an issue in the GitHub repository.
