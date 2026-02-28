cd C:\Users\rainmaker\rook24builds-repo
$token = Read-Host "Enter your GitHub token (paste and press Enter)"
git remote set-url origin https://Rook24Builds:${token}@github.com/Rook24Builds/invoiceforge.git
git push -u origin main
Write-Host "Done! Now go to https://github.com/Rook24Builds/invoiceforge/settings/pages to enable Pages"