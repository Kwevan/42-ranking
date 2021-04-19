def delete_collection(firestore, name)
    cities_ref = firestore.col name
    query      = cities_ref

    query.get do |document_snapshot|
        puts "Deleting document #{document_snapshot.document_id}."
        document_ref = document_snapshot.ref
        document_ref.delete
    end

end

def update_logs(firestore, doc_name, campus_data)
	(puts "**** Firestore not found ****"; return;) if (!firestore)
	settings_ref = firestore.doc "settings/#{doc_name}"
	settings_ref.set campus_data
end
