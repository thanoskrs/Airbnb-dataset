CREATE OR REPLACE FUNCTION log_listing_host_update_on_changes()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN
	IF (TG_OP = 'DELETE') THEN
		UPDATE host
		SET total_listings_count = total_listings_count - 1
		WHERE id = OLD.host_id;
		RETURN OLD;
	ELSIF (TG_OP = 'INSERT') THEN
		UPDATE host
		SET total_listings_count = total_listings_count + 1
		WHERE id = NEW.host_id;
		RETURN NEW;
	END IF;
END;
$$

CREATE TRIGGER listing_host_update_on_changes
BEFORE INSERT OR DELETE
ON listing
FOR EACH ROW
EXECUTE PROCEDURE log_listing_host_update_on_changes()


/* Delete all reviews from review table and review_summary table, 
	when a listing is deleted*/

CREATE OR REPLACE FUNCTION log_review_reviewSummary_update_on_changes()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN
	DELETE FROM review_summary
	WHERE listing_id = OLD.id;
	DELETE FROM review
	WHERE listing_id = OLD.id;
	
	RETURN OLD;
END;
$$

CREATE TRIGGER review_reviewSummary_update_on_changes
BEFORE DELETE 
ON listing
FOR EACH ROW
EXECUTE PROCEDURE log_review_reviewSummary_update_on_changes()
