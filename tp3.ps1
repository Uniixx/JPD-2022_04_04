Clear-Host

function CreateUser($name) {
  $user = Get-LocalUser | Where-Object Name -eq $name;

  if (!$user) {
    $user = New-LocalUser -Name $name -FullName $name -Description "Compte pour $name";
    Write-Host "Cr�ation de l'utilisateur $name avec succ�s!";
  } else {
    Write-Host "Utilisateur d�ja �xistant!";
  }
}

CreateUser("nathan");