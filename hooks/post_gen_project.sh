#!/bin/bash
echo "Do you wish create a new GitHub repository?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	    scripts/01_create_github_repo.sh; break;;
        No ) break;;
    esac
done

echo "Do you wish to generate a key for deploying documentation?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	    scripts/02_generate_ecdsa_key.sh; break;;
        No ) break;;
    esac
done


echo "Do you wish to initialize the GitHub repository?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	    scripts/03_initialize_github_repo.sh; break;;
        No ) break;;
    esac
done

echo "Do you wish to upload the key for Travis-CI documentation deployment to GitHub?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	    scripts/04_upload_deploy_key.sh; break
	    echo "Do you wish to deploy the uploaded key to Travis CI?"
	    select yn in "Yes" "No"; do
		case $yn in
		    Yes )
			scripts/05_deploy_key_to_travis_ci.sh; break
			;;
		    No ) break
			 ;;
		esac
	    done
	    break
	    ;;
        No ) break
	     ;;
    esac
done
echo "Congratulations! You have successfully created a new package."
